package modules::Home;

use Class::Singleton;
use base 'Class::Singleton';
use vars qw($VERSION);
use strict;

$VERSION = sprintf "%d.%03d", q$Revision: 1.2 $ =~ /(\d+)\.(\d+)/;

sub parameter {
  my ($self, $mgr) = @_;

  $mgr->{Template} = $mgr->{TmplFiles}->{Home};

  $mgr->{Page}->fill_main_part($mgr);
  $mgr->{Page}->fill_user_part($mgr);
  $mgr->{Page}->fill_lang_part($mgr);

  my $method = $mgr->{CGI}->param('method') || undef;

  if (defined $method) {
    if ($method eq "cat_admin") {
      $self->show_category_admin($mgr);
    }
  } else {
    $self->show_categories($mgr);
  }

  1;
}

sub show_category_admin {
  my ($self, $mgr) = @_;

  unless ($mgr->{Func}->check_for_user($mgr, 2)) {
    # Error handling ...
    return 1;
  }

  # Display categories for administration.
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
  my $link  = "%s&cat_id=%s&method=show_cat";

  foreach my $cat (@cats) {

    # Only if we have parent categories or texts in this
    # category, we make a link.
    if (($cat->[3] != 0) || ($cat->[2] != 0)) {
      $page_cats[$count]{PAGE_CAT_LINK} = 
	sprintf($link, $mgr->my_url(), $cat->[0]);
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
	    sprintf($link, $mgr->my_url(), $p_cat->[0]);
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
}

1;
