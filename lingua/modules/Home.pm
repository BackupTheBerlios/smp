package modules::Home;

use Class::Singleton;
use base 'Class::Singleton';
use vars qw($VERSION);
use strict;

$VERSION = sprintf "%d.%03d", q$Revision: 1.14 $ =~ /(\d+)\.(\d+)/;

#-----------------------------------------------------------------------------#
# CALL:   $self->parameter($mgr).                                             #
#                                                                             #
#         $mgr = manager object.                                              #
#                                                                             #
# AUTHOR: Sören Wurch (sowuinfo@cs.tu-berlin.de)                              #
#                                                                             #
# DESC:   Main function for the Home module.                                  #
#                                                                             #
# RETURN: none.                                                               #
#-----------------------------------------------------------------------------#
sub parameter {
  my ($self, $mgr) = @_;

  my $method = $mgr->{CGI}->param('method') || '';

  if ($method eq "cat_admin") {
    $self->show_tree($mgr);
  } elsif ($method eq "show_cat") {
    $self->show_tree($mgr);
  } elsif ($method eq "cat_open") {
    $mgr->{Tree}->open_tree($mgr);
    $self->show_tree($mgr);
  } elsif ($method eq "cat_close") {
    $mgr->{Tree}->close_tree($mgr);
    $self->show_tree($mgr);
  } elsif ($method eq "lock_cat") {
    $self->lock_cat($mgr);
    $self->show_tree($mgr);
  } elsif ($method eq "unlock_cat") {
    $self->unlock_cat($mgr);
    $self->show_tree($mgr);
  } elsif ($method eq "delete_cat") {
    $self->delete_cat($mgr);
    $self->show_tree($mgr);
  } else {
    $self->show_tree($mgr);
  }

  $mgr->{TmplData}{PAGE_CAT_ID} = $mgr->{CGI}->param('cat_id') || '';
}

#-----------------------------------------------------------------------------#
# CALL:   $self->show_tree($mgr).                                             #
#                                                                             #
#         $mgr = manager object.                                              #
#                                                                             #
# DESC:   Creates a tree with all the categories.                             #
#                                                                             #
# RETURN: none.                                                               #
#-----------------------------------------------------------------------------#
sub show_tree {
  my ($self, $mgr) = @_;

  my $mode = $mgr->{CGI}->param('mode') || '';

  if ($mode eq "admin") {
    unless ($mgr->{Func}->check_for_user($mgr, 2)) {
      $mode = "";
    }
  }

  my $cat_id = $mgr->{CGI}->param('cat_id') || '0';
  my $count  = 0;
  my (%list, @result, @open);

  if ($mode eq "admin") {
    @open = split (',', $mgr->{Session}->get("AdminCatsOpen") || '');
    $mgr->{TmplData}{PAGE_CAT_ADMIN}   = 1;
    $mgr->{TmplData}{PAGE_LANG_000015} = $mgr->{Func}->get_text($mgr, 15);
  } else {
    @open = split (',', $mgr->{CGI}->param('open') || '');
  }

  # Get all the ids, which are open.
  foreach my $open (@open) {
    $list{$open} = 1;
  }

  $mgr->{Template}  = $mgr->{TmplFiles}->{Home_Tree};
  ($count, @result) = $mgr->{Tree}->create_tree($mgr, $cat_id, \%list, $count, \@result, $mode);

  # Important. If we delete a category, we must check the last value here.
  if (defined $result[0]) {
    delete $result[$#result] if (!defined $result[$#result]{PAGE_CAT_NAME});
  }

  $mgr->{TmplData}{PAGE_LOOP_CATS} = \@result;
}

#-----------------------------------------------------------------------------#
# CALL:   $self->lock_cat($mgr).                                              #
#                                                                             #
#         $mgr = manager object.                                              #
#                                                                             #
# DESC:   Updates the status from a given category to 0.                      #
#                                                                             #
# RETURN: none.                                                               #
#-----------------------------------------------------------------------------#
sub lock_cat {
  my ($self, $mgr) = @_;
  my $cat_id       = $mgr->{CGI}->param('cat_id') || '';

  if ($cat_id eq "") {
    $mgr->fatal_error("Wrong call.");
  }

  my $cat_table = $mgr->{Tables}->{CATS};
  my $dbh       = $mgr->connect();
  my $sth       = $dbh->prepare(<<SQL);

UPDATE $cat_table 
SET status = '0' 
WHERE cat_id = ?

SQL

  unless ($sth->execute($cat_id)) {
    warn sprintf("[Error:] Trouble updating data in [%s]. Reason: [%s].", 
		 $cat_table, $dbh->errstr());
    $mgr->fatal_error("Database error."); 
  }

  $sth->finish();

  $mgr->{CGI}->param(cat_id => '0');
}

#-----------------------------------------------------------------------------#
# CALL:   $self->unlock_cat($mgr).                                            #
#                                                                             #
#         $mgr = manager object.                                              #
#                                                                             #
# DESC:   Updates the status for a given category to 1.                       #
#                                                                             #
# RETURN: none.                                                               #
#-----------------------------------------------------------------------------#
sub unlock_cat {
  my ($self, $mgr) = @_;
  my $cat_id       = $mgr->{CGI}->param('cat_id') || '';

  if ($cat_id eq "") {
    $mgr->fatal_error("Wrong call.");
  }

  my $cat_table = $mgr->{Tables}->{CATS};
  my $dbh       = $mgr->connect();
  my $sth       = $dbh->prepare(<<SQL);

UPDATE $cat_table 
SET status = '1' 
WHERE cat_id = ?

SQL

  unless ($sth->execute($cat_id)) {
    warn sprintf("[Error:] Trouble updating data in [%s]. Reason: [%s].", 
		 $cat_table, $dbh->errstr());
    $mgr->fatal_error("Database error."); 
  }

  $sth->finish();

  $mgr->{CGI}->param(cat_id => '0');
}

sub delete_cat {
  my ($self, $mgr) = @_;
  my $cat_id       = $mgr->{CGI}->param('cat_id') || '';

  if ($cat_id eq "") {
    $mgr->fatal_error("Wrong call.");
  }

  my @cat = $mgr->{Func}->get_cat($mgr, $cat_id);

  # If the text count or the cat count not equal 0, we can't delete this category.
  if ((!defined $cat[1]) || (!defined $cat[3]) || ($cat[1] != 0) || ($cat[3] != 0)) {
    $mgr->fatal_error("Wrong call.");
  }

  my $cat_table  = $mgr->{Tables}->{CATS};
  my $dict_table = $mgr->{Tables}->{DICT};

  my $dbh = $mgr->connect();
  $dbh->do("LOCK TABLES $cat_table WRITE, $dict_table WRITE");

  # Delete the category.
  my $sth = $dbh->prepare(<<SQL);

DELETE FROM $cat_table
WHERE cat_id = ?

SQL

  unless ($sth->execute($cat_id)) {
    warn sprintf("[Error:] Trouble deleting data from [%s]. Reason: [%s].", 
		 $cat_table, $dbh->errstr());
    $mgr->fatal_error("Database error.");  
  }

  $sth->finish();

  # Delete the dictionary entry for this category.
  $sth = $dbh->prepare(<<SQL);

DELETE FROM $dict_table
WHERE dict_id = ?

SQL

  unless ($sth->execute($cat[7])) {
    warn sprintf("[Error:] Trouble deleting data from [%s]. Reason: [%s].", 
		 $dict_table, $dbh->errstr());
    $mgr->fatal_error("Database error.");  
  }

  $sth->finish();

  # Updating the category count for in the parent category.
  if ($cat[5] != 0) {
    $sth = $dbh->prepare(<<SQL);

UPDATE $cat_table
SET cat_count = cat_count-1
WHERE cat_id = ?

SQL
  
    unless ($sth->execute($cat[5])) {
      warn sprintf("[Error:] Trouble updating data in [%s]. Reason: [%s].", 
		   $cat_table, $dbh->errstr());
      $mgr->fatal_error("Database error.");  
    }

    $sth->finish();
  }

  $dbh->do("UNLOCK TABLES");

  # Change the open categories.
  my @admin_open   = split(',', $mgr->{Session}->get("AdminCatsOpen") || '');
  my @all_open = split(',', $mgr->{CGI}->param('open') || '');

  my (%all_list, %admin_list);

  foreach my $open (@all_open) {
    next if ($open eq $cat_id);
    $all_list{$open} = 1;
  }

  foreach my $open (@admin_open) {
    next if ($open eq $cat_id);
    $admin_list{$open} = 1;
  }

  $mgr->{Session}->del("AdminCatsOpen");
  $mgr->{Session}->set("AdminCatsOpen", join(',', keys %admin_list));
  $mgr->{CGI}->param(open => join(',', keys %all_list));

  $mgr->{CGI}->param(cat_id => '0');
}

1;
