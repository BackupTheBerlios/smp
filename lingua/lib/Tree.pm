package lib::Tree;

use strict;

sub new {
  my $proto = shift;
  my $class = ref($proto) || $proto;
  my $self  = {};

  bless ($self, $class);
}

sub create_tree {
  my ($self, $mgr, $cat_id, $list, $count, $result, $mode) = @_;

  my %list     = %$list;
  my @result   = @$result;
  my @cats     = $mgr->{Func}->get_cats($mgr, $cat_id);
  my $new_text = $mgr->{Func}->get_text($mgr, 6000);

  foreach my $cat (@cats) {
    if ($cat->[3] != 0) {
      $result[$count]{PAGE_BUTTON} = 1;
    }

    if ((defined $mgr->{SessionId}) && ($mode ne "admin")) {
      $result[$count]{PAGE_CAT_NEW_TEXT}      = 1;
      $result[$count]{PAGE_CAT_NEW_TEXT_LINK} = sprintf("%s&cat_id=%s", 
							$mgr->my_url(ACTION => "text",
								     METHOD => "new"),
						        $cat->[0]);
      $result[$count]{PAGE_LANG_006000}       = $new_text;
    }

    if ($mode eq "admin") {
      # someting for cat administration ...
    } else {
      if ($cat->[2] > 0) {
	$result[$count]{PAGE_CAT_TEXT} = 1;
	$result[$count]{PAGE_CAT_LINK} = sprintf("%s&cat_id=%s",
						 $mgr->my_url(METHOD => "show_text"),
						 $cat->[0]);
      }
    }

    if (defined $list{$cat->[0]}) {
      $result[$count]{PAGE_CAT_NAME}     = $mgr->to_unicode($cat->[1]);

      # Create a link for closing the category.
      $result[$count]{PAGE_CLOSE_BUTTON} = 1;

      if ($mode eq "admin") {
	$result[$count]{PAGE_CLOSE_LINK}   = sprintf("%s&cat_id=%s", 
						     $mgr->my_url(METHOD => "cat_close",
								  MODE   => "admin"), 
						     $cat->[0]);
      } else {
	$result[$count]{PAGE_CLOSE_LINK}   = sprintf("%s&cat_id=%s", 
						     $mgr->my_url(METHOD => "cat_close"), 
						     $cat->[0]);
      }

      $count++;

      my $tmp_count = $count;
      my @tmp;

      # Recursive call to get all sub categories from the parent category.
      ($count, @tmp) = $self->create_tree($mgr, $cat->[0], \%list, $count, \@result, $mode);

      # Open the ul for this sub categories.
      $result[$tmp_count]{PAGE_OPEN_CAT} = 1;

      # Put in the main result array all the values from the sub categories.
      for (;$tmp_count < $count; $tmp_count++) {
	my $tmp_cat = $tmp[$tmp_count];

	# Do it for all the keys for the current category.
	foreach my $tmp_cat_value (keys %$tmp_cat) {
	  $result[$tmp_count]{$tmp_cat_value} = $tmp_cat->{$tmp_cat_value};
	}
      }

      # Close the ul for this sub categories.
      $result[$count-1]{PAGE_CLOSE_CAT} = 1;

    } else {
      # Create a link for opening the category.
      if ($cat->[3] != 0) {
	$result[$count]{PAGE_OPEN_BUTTON} = 1;

	if ($mode eq "admin") {
	  $result[$count]{PAGE_OPEN_LINK}   = sprintf("%s&cat_id=%s", 
						      $mgr->my_url(METHOD => "cat_open",
								   MODE   => "admin"), 
						      $cat->[0]);
	} else {
	  $result[$count]{PAGE_OPEN_LINK}   = sprintf("%s&cat_id=%s", 
						      $mgr->my_url(METHOD => "cat_open"), 
						      $cat->[0]);
	}
      }

      $result[$count]{PAGE_CAT_NAME} = $mgr->to_unicode($cat->[1]);
      $count++;
    }
  }

  return ($count, @result);
}

sub open_tree {
  my ($self, $mgr) = @_;

  my $cat_id = $mgr->{CGI}->param('cat_id') || "0";
  my @cat    = $mgr->{Func}->get_cat($mgr, $cat_id);
  my $mode   = $mgr->{CGI}->param('mode') || '';

  # Set the cgi variable cat_id with a new value.
  $mgr->{CGI}->param(-name => "cat_id", -value => "0");

  # Open the category, if this category has parent categories.
  if ((defined $cat[3]) && ($cat[3] ne 0)) {
    my (@open, %list);

    if ($mode eq "admin") {
      @open = split(',', $mgr->{Session}->get("AdminCatsOpen") || '');
    } else {
      @open = split(',', $mgr->{CGI}->param('open') || '');
    }

    foreach my $open (@open) {
      $list{$open} = 1;
    }

    $list{$cat_id} = 1;

    # Set the cgi parameter open with category ids.
    if ($mode eq "admin") {
      $mgr->{Session}->del("AdminCatsOpen");
      $mgr->{Session}->set("AdminCatsOpen", join(',', keys %list));
    } else {
      $mgr->{CGI}->param(open => join(',', keys %list));
    }
  }
}

sub close_tree {
  my ($self, $mgr) = @_;

  my $cat_id = $mgr->{CGI}->param('cat_id') || "0";
  my $mode   = $mgr->{CGI}->param('mode') || '';

  $mgr->{CGI}->param(-name => "cat_id", -value => "0");

  # Get all the ids of the open categories.
  my (@open, %list);

  if ($mode eq "admin") {
    @open = split(',', $mgr->{Session}->get("AdminCatsOpen") || '');
  } else {
    @open = split(',', $mgr->{CGI}->param('open') || '');
  }

  foreach my $open (@open) {
    next if ($open eq $cat_id);
    $list{$open} = 1;
  }

  # Set the cgi parameter open with category ids.
  if ($mode eq "admin") {
    $mgr->{Session}->del("AdminCatsOpen");
    $mgr->{Session}->set("AdminCatsOpen", join(',', keys %list));
  } else {
    $mgr->{CGI}->param(open => join(',', keys %list));
  }
}

1;
