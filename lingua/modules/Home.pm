package modules::Home;

use Class::Singleton;
use base 'Class::Singleton';
use vars qw($VERSION);
use strict;

$VERSION = sprintf "%d.%03d", q$Revision: 1.15 $ =~ /(\d+)\.(\d+)/;

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
    } elsif ($method eq "new_cat") {
	$self->new_cat_form($mgr);
    } elsif (defined $mgr->{CGI}->param('cat_new')) {
	$self->add_new_cat($mgr);
    } elsif ($method eq "change_cat") {
	$self->change_cat_form($mgr);
    } elsif (defined $mgr->{CGI}->param('cat_change')) {
	$self->change_cat($mgr);
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

#-----------------------------------------------------------------------------#
# CALL:   $self->delete_cat($mgr).                                            #
#                                                                             #
#         $mgr = manager object.                                              #
#                                                                             #
# DESC:   Deletes one category, if this category is  empty.                   #
#                                                                             #
# RETURN: none.                                                               #
#-----------------------------------------------------------------------------#
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

sub new_cat_form {
    my $self = shift;
    my $mgr  = shift;

    unless ($mgr->{Func}->check_for_user($mgr, 2)) {
	$mgr->fatal_error("Wrong call.");
    }

    $mgr->{TmplData}{CAT_BACK}         = $mgr->my_url(METHOD => "cat_admin",
						      MODE   => "admin");
    $mgr->{TmplData}{PAGE_LANG_007001} = $mgr->{Func}->get_text($mgr, 7001);
    $mgr->{TmplData}{PAGE_LANG_006005} = $mgr->{Func}->get_text($mgr, 6005);
    $mgr->{TmplData}{PAGE_LANG_000001} = $mgr->{Func}->get_text($mgr, 1);
    $mgr->{TmplData}{PAGE_LANG_000002} = $mgr->{Func}->get_text($mgr, 2);
    $mgr->{TmplData}{PAGE_LANG_000016} = $mgr->{Func}->get_text($mgr, 16);
    $mgr->{TmplData}{PAGE_LANG_006000} = $mgr->{Func}->get_text($mgr, 6000);


    $mgr->{Template} = $mgr->{TmplFiles}->{Cat_New};
}

sub change_cat_form {
    my $self = shift;
    my $mgr  = shift;
    my $mode = shift;

    my $cat_id = $mgr->{CGI}->param('cat_id') || '';

    unless ($mgr->{Func}->check_for_user($mgr, 2)) {
	$mgr->fatal_error("Wrong call.");
    }

    unless ($cat_id ne "") {
	$mgr->fatal_error("Wrong call.");
    }

    $mgr->{TmplData}{CAT_BACK}         = $mgr->my_url(METHOD => "cat_admin",
						      MODE   => "admin");
    $mgr->{TmplData}{PAGE_LANG_007001} = $mgr->{Func}->get_text($mgr, 7001);
    $mgr->{TmplData}{PAGE_LANG_006005} = $mgr->{Func}->get_text($mgr, 6005);
    $mgr->{TmplData}{PAGE_LANG_000001} = $mgr->{Func}->get_text($mgr, 1);
    $mgr->{TmplData}{PAGE_LANG_000002} = $mgr->{Func}->get_text($mgr, 2);
    $mgr->{TmplData}{PAGE_LANG_000016} = $mgr->{Func}->get_text($mgr, 16);
    $mgr->{TmplData}{PAGE_LANG_006001} = $mgr->{Func}->get_text($mgr, 6001);

    my @cat = $mgr->{Func}->get_cat($mgr, $cat_id);
    
    my $dbh = $mgr->connect();
    my $sth = $dbh->prepare(sprintf("SELECT de, en, fr FROM %s WHERE dict_id = ?", 
				    $mgr->{Tables}->{DICT}));

    unless ($sth->execute($cat[7])) {
	warn sprintf("[Error]: Trouble selecting data from table [%s]. Reason: [%s].",
			 $mgr->{Tables}->{DICT}, $dbh->errstr);
	$mgr->fatal_error("Database error.");
    }

    unless ($mode) {
	my @data = $sth->fetchrow_array();
	$sth->finish();

	$mgr->{TmplData}{CAT_NAME_DE} = $data[0];
	$mgr->{TmplData}{CAT_NAME_EN} = $data[1];
	$mgr->{TmplData}{CAT_NAME_FR} = $data[2];
    }

    $mgr->{Template} = $mgr->{TmplFiles}->{Cat_Change};
}

sub add_new_cat {
    my $self = shift;
    my $mgr  = shift;

    my $parent_id = $mgr->{CGI}->param('cat_id') || '0';
    my $de        = $mgr->{CGI}->param('de') || '';
    my $en        = $mgr->{CGI}->param('en') || '';
    my $fr        = $mgr->{CGI}->param('fr') || '';

    unless ($mgr->{Func}->check_for_user($mgr, 2)) {
	$mgr->fatal_error("Wrong call.");
    }

    if ($de && $en && $fr) {
	my $dbh = $mgr->connect();
	my @cat = $mgr->{Func}->get_cat($mgr, $parent_id);

	$dbh->do(sprintf("LOCK TABLES %s WRITE, %s WRITE", 
			 $mgr->{Tables}->{DICT},
			 $mgr->{Tables}->{CATS}));  

	my $sth = $dbh->prepare(sprintf("INSERT INTO %s (de, en, fr) VALUES (?, ?, ?)", 
					$mgr->{Tables}->{DICT}));

	unless ($sth->execute($de, $en, $fr)) {
	    warn sprintf("[Error]: Trouble inserting data into table [%s]. Reason: [%s].",
			 $mgr->{Tables}->{DICT}, $dbh->errstr);
	    $dbh->do("UNLOCK TABLES");
	    $mgr->fatal_error("Database error.");
	}

	my $insert_id = $sth->{mysql_insertid};

	

	$sth = $dbh->prepare(sprintf("INSERT INTO %s (parent_id, lang_id, depth, cat_count,".
				     "text_count, status) VALUES (?, ?, ?, 0, 0, 1)",
				     $mgr->{Tables}->{CATS}));
	
	unless ($sth->execute($parent_id, $insert_id, $cat[4])) {
	    warn sprintf("[Error]: Trouble inserting data into table [%s]. Reason: [%s].",
			 $mgr->{Tables}->{CATS}, $dbh->errstr);
	    $dbh->do("UNLOCK TABLES");
	    $mgr->fatal_error("Database error.");
	}

	unless ($dbh->do(sprintf("UPDATE %s SET cat_count = cat_count + 1 WHERE cat_id = '%s'",
				 $mgr->{Tables}->{CATS}, $parent_id))) {
	    warn sprintf("[Error]: Trouble updating data in table [%s]. Reason: [%s].",
			 $mgr->{Tables}->{CATS}, $dbh->errstr);
	    $dbh->do("UNLOCK TABLES");
	    $mgr->fatal_error("Database error.");
	}

	$sth->finish();
	$dbh->do("UNLOCK TABLES");

	$mgr->{CGI}->param(mode => 'admin');
	$mgr->{CGI}->param(cat_id => '0');

	$self->show_tree($mgr);
    } else {
	$mgr->{TmplData}{TEXT_ERROR_LANGS} = $mgr->{Func}->get_text($mgr, 6006);
	$mgr->{TmplData}{CAT_NAME_DE} = $de;
	$mgr->{TmplData}{CAT_NAME_EN} = $en;
	$mgr->{TmplData}{CAT_NAME_FR} = $fr;
	$self->new_cat_form($mgr);
    }

}

sub change_cat {
    my $self = shift;
    my $mgr  = shift;

    my $cat_id = $mgr->{CGI}->param('cat_id') || '0';
    my $de     = $mgr->{CGI}->param('de') || '';
    my $en     = $mgr->{CGI}->param('en') || '';
    my $fr     = $mgr->{CGI}->param('fr') || '';

    unless ($mgr->{Func}->check_for_user($mgr, 2)) {
	$mgr->fatal_error("Wrong call.");
    }

    if ($de && $en && $fr) {
	my $dbh = $mgr->connect();
	my @cat = $mgr->{Func}->get_cat($mgr, $cat_id);
	
	$dbh->do(sprintf("LOCK TABLES %s WRITE", $mgr->{Tables}->{DICT}));

	my $sth = $dbh->prepare(sprintf("UPDATE %s SET de = ?, en = ?, fr = ? WHERE dict_id = ?",
					$mgr->{Tables}->{DICT}));

	unless ($sth->execute($de, $en, $fr, $cat[7])) {
	    warn sprintf("[Error]: Trouble updating data int table [%s]. Reason: [%s].",
			 $mgr->{Tables}->{DICT}, $dbh->errstr);
	    $mgr->fatal_error("Database error.");
	}

	$sth->finish();

	$dbh->do("UNLOCK TABLES");

	$mgr->{CGI}->param(mode => 'admin');
	$mgr->{CGI}->param(cat_id => '0');

	$self->show_tree($mgr);

    } else {
	$mgr->{TmplData}{TEXT_ERROR_LANGS} = $mgr->{Func}->get_text($mgr, 6006);
	$mgr->{TmplData}{CAT_NAME_DE} = $de;
	$mgr->{TmplData}{CAT_NAME_EN} = $en;
	$mgr->{TmplData}{CAT_NAME_FR} = $fr;
	$self->change_cat_form($mgr, 1);
    } 
}

1;
