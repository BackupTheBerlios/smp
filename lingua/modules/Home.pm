package modules::Home;

use Class::Singleton;
use base 'Class::Singleton';
use vars qw($VERSION);
use strict;

$VERSION = sprintf "%d.%03d", q$Revision: 1.5 $ =~ /(\d+)\.(\d+)/;

sub parameter {
  my ($self, $mgr) = @_;

  my $method = $mgr->{CGI}->param('method') || '';

  if ($method eq "cat_admin") {
    $self->show_category_admin($mgr);
  } elsif ($method eq "show_cat") {
    $self->show_categories($mgr);
  } else {
    $self->show_categories($mgr);
  }
}

sub show_category_admin {
  my ($self, $mgr) = @_;

  unless ($mgr->{Func}->check_for_user($mgr, 2)) {
    # Error handling ...
    return 1;
  }

  my $cat_id = $mgr->{CGI}->param('cat_id') || "0";
  my @open   = split(',', $mgr->{CGI}->param('open') || '');
  my %list;

  # Get all the ids from the categories, which are open.
  foreach my $open (@open) {
    $list{$open} = 1;
  }

  $mgr->{TmplData}{PAGE_LANG_000015} = $mgr->{Func}->get_text($mgr, 15);
  $mgr->{Template}                   = $mgr->{TmplFiles}->{Home_Cats};

  my $count  = 0;
  my @result;

  @result = $self->show_cat_tree($mgr, $cat_id, \%list, $count, \@result);

  $mgr->{TmplData}{PAGE_LOOP_CATS} = \@result;
}

sub show_cat_tree {
  my ($self, $mgr, $cat_id, $list, $count, $result) = @_;

  my %list   = %$list;
  my @result = @$result;

  my @cats   = $mgr->{Func}->get_cats($mgr, $cat_id);

  foreach my $cat (@cats) {
    if ($cat->[3] != 0) {
      $result[$count]{PAGE_BUTTON} = 1;
    }

    if (defined $list{$cat->[0]}) {

      if ($cat->[4] != 0) {
	for (my $i = 0; $i <= $cat->[4]; $i++) {
	  #$result .= "&nbsp;";
	}
      }

      $result[$count]{PAGE_CAT_NAME}     = $cat->[1];

      # Create a link for closing the category.
      $result[$count]{PAGE_CLOSE_BUTTON} = 1;
      $result[$count]{PAGE_CLOSE_LINK}   = sprintf("%s&cat_id=%s&open=%s", 
						   $mgr->my_url(METHOD => "cat_close"), 
						   $cat->[0], keys %list);
      $count++;

      my @tmp = $self->show_cat_tree($mgr, $cat->[0], \%list, $count, \@result);

    } else {
      if ($cat->[4] != 0) {
	for (my $i = 0; $i <= $cat->[4]; $i++) {
	  #$result .= "&nbsp;";
	}
      }

      # Create a link for opening the category.
      if ($cat->[3] != 0) {
	$result[$count]{PAGE_OPEN_BUTTON} = 1;
	$result[$count]{PAGE_OPEN_LINK}   = sprintf("%s&cat_id=%s&open=%s", 
						    $mgr->my_url(METHOD => "cat_open"), 
						    $cat->[0], keys %list);
      }

      $result[$count]{PAGE_CAT_NAME} = $cat->[1];
      $count++;
    }
  }

  return @result;
}

sub show_categories {
  my ($self, $mgr) = @_;

  # If we dont have a right cat_id, we take the 0.
  my $cat_id = $mgr->{CGI}->param('cat_id') || "0";

  # Write the current category id into the template.
  $mgr->{TmplData}{PAGE_CAT_ID} = $cat_id;

  # Select the categories with parent id equal $cat_id.
  my @cats = $mgr->{Func}->get_cats($mgr, $cat_id);

  my @page_cats;
  my $count = 0;

  foreach my $cat (@cats) {

    # Only if we have parent categories or texts in this
    # category, we make a link.
    if (($cat->[3] != 0) || ($cat->[2] != 0)) {
      $page_cats[$count]{PAGE_CAT_LINK} = 
	sprintf("%s&cat_id=%s", $mgr->my_url(METHOD => "show_cat"), $cat->[0]);
    }

    $page_cats[$count]{PAGE_CAT_NAME}       = $cat->[1];
    $page_cats[$count]{PAGE_CAT_TEXT_COUNT} = $cat->[2];

    # Only two categories at one level.
    if ($count % 2) {
      $page_cats[$count]{PAGE_CAT_CLOSE_TR} = 1;
    } else {
      $page_cats[$count]{PAGE_CAT_OPEN_TR} = 1;
    }

    my (@p_cats, @tmp_cats);
    my $p_count = 0;
    my $check   = 0;

    # Only if we have parent categories, we show up to
    # three parent categories of the current category.
    if ($cat->[3] != 0) {
      @tmp_cats = $mgr->{Func}->get_cats($mgr, $cat->[0]);

      foreach my $p_cat (@tmp_cats) {
	
	# Show up to three parent categories.
	last if ($check == 3);

	# Only if we have parent categories or texts in this 
	# category, we make a link.
	if (($p_cat->[3] != 0) || ($p_cat->[2])) {
	  $p_cats[$p_count]{PAGE_P_CAT_LINK} = 
	    sprintf("%s&cat_id=%s", $mgr->my_url(METHOD => "show_cat"), $p_cat->[0]);
	}

	$p_cats[$p_count]{PAGE_P_CAT_NAME}       = $p_cat->[1];
	$p_cats[$p_count]{PAGE_P_CAT_TEXT_COUNT} = $p_cat->[2];

	$check++;
	$p_count++;
      }

      $page_cats[$count]{PAGE_LOOP_P_CAT} = \@p_cats;
    }

    $count++;
  }

  $mgr->{TmplData}{PAGE_LOOP_CATS} = \@page_cats;
  $mgr->{Template}                 = $mgr->{TmplFiles}->{Home};
}

1;
