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

  my %list        = %$list;
  my @result      = @$result;
  my @cats        = $mgr->{Func}->get_cats($mgr, $cat_id);
  my $new_text    = $mgr->{Func}->get_text($mgr, 6000);
  my $change_text = $mgr->{Func}->get_text($mgr, 6001);
  my $delete_text = $mgr->{Func}->get_text($mgr, 6002);
  my $lock_text   = $mgr->{Func}->get_text($mgr, 6003);
  my $unlock_text = $mgr->{Func}->get_text($mgr, 6004);

  foreach my $cat (@cats) {
    # Only in the administration mode show all categories.
    next if (($cat->[5] != 1) && ($mode ne "admin"));

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

    # For the administration mode.
    if ($mode eq "admin") {
      $result[$count]{PAGE_CAT_ADMIN}       = 1;
      $result[$count]{CAT_ADMIN_NEW_CAT}    = sprintf("%s&cat_id=%s",
						      $mgr->my_url(METHOD => "new_cat",
								   MODE   => "admin"),
						      $cat->[0]);
      $result[$count]{PAGE_LANG_006000}     = $new_text;
      $result[$count]{CAT_ADMIN_CHANGE_CAT} = sprintf("%s&cat_id=%s",
						      $mgr->my_url(METHOD => "change_cat",
								   MODE   => "admin"),
						      $cat->[0]);
      $result[$count]{PAGE_LANG_006001}     = $change_text;

      # Only if we dont have cats and texts in this category, we make a delete link.
      if (($cat->[2] == 0) && ($cat->[3] == 0)) {
	$result[$count]{IF_CAT_ADMIN_DELETE_CAT} = 1;
	$result[$count]{CAT_ADMIN_DELETE_CAT}    = sprintf("%s&cat_id=%s",
							   $mgr->my_url(METHOD => "delete_cat",
									MODE   => "admin"),
							   $cat->[0]);
      }

      $result[$count]{PAGE_LANG_006002}     = $delete_text;

      # Locking and unlocking for the choosen category.
      if ($cat->[5] == 1) {
	$result[$count]{CAT_ADMIN_LOCK}       = 1;
	$result[$count]{CAT_ADMIN_LOCK_CAT}   = sprintf("%s&cat_id=%s",
						        $mgr->my_url(METHOD => "lock_cat",
								     MODE   => "admin"),
						        $cat->[0]);
	$result[$count]{PAGE_LANG_006003}     = $lock_text;
      } else {
	$result[$count]{CAT_ADMIN_UNLOCK_CAT} = sprintf("%s&cat_id=%s",
							$mgr->my_url(METHOD => "unlock_cat",
								     MODE   => "admin"),
							$cat->[0]);
	$result[$count]{PAGE_LANG_006004}     = $unlock_text;
      }
    } else {

      my $check_status = $self->check_text_status($mgr, $cat->[0]);

      if (($cat->[2] > 0) && ($check_status != 0)) {
	$result[$count]{PAGE_CAT_TEXT} = 1;
	$result[$count]{PAGE_CAT_LINK} = sprintf("%s&cat_id=%s",
						 $mgr->my_url(ACTION => "text",
							      METHOD => "show_texts"),
						 $cat->[0]);
      }
    }

    if (defined $list{$cat->[0]}) {
      $result[$count]{PAGE_CAT_NAME}     = $cat->[1];

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

      $result[$count]{PAGE_CAT_NAME} = $cat->[1];
      $count++;
    }
  }

  # For the administration mode. Startcategory with a new category link.
  if ($mode eq "admin") {
    $mgr->{TmplData}{CAT_ADMIN_START_NEW} = sprintf("%s&cat_id=0",
						    $mgr->my_url(METHOD => "new_cat",
								 MODE   => "admin"));
    $mgr->{TmplData}{PAGE_LANG_006000} = $new_text;
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

sub check_text_status {
  my ($self, $mgr, $cat_id) = @_;

  my $text_table = $mgr->{Tables}->{TEXT};
  my $dbh        = $mgr->connect();
  my $sth        = $dbh->prepare(<<SQL);

SELECT COUNT(*) AS check_status
FROM $text_table
WHERE status = '1'

SQL

  unless ($sth->execute()) {
    warn sprintf("[Error:] Trouble selecting data from [%s]. Reason: [%s].", 
		 $text_table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }

  my $check = $sth->fetchrow_array();

  $sth->finish();

  return $check;
}

1;
