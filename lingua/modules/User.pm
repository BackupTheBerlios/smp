package modules::User;

use Class::Singleton;
use base 'Class::Singleton';
use vars qw($VERSION);
use strict;

$VERSION = sprintf "%d.%03d", q$Revision: 1.3 $ =~ /(\d+)\.(\d+)/;

#
# this method is called by the manager (main.cgi)
#
sub parameter {
    my ($self, $mgr) = @_;

    $mgr->{Template} = $mgr->{TmplFiles}->{User_Pers};

    $mgr->{Page}->fill_main_part($mgr);
    $mgr->{Page}->fill_user_part($mgr);
    $mgr->{Page}->fill_lang_part($mgr);

    if ($mgr->{CGI}->param('change_email'))
    {
	$self->change_email($mgr);
    }
    else 
    {
	$self->show_pers_page($mgr);
    }

    return 1;
}



#
# updates user table upon change
# Params: 1. Manager ref
#
sub change_email
{
    my ($self, $mgr) = @_;

    my $email = $mgr->{CGI}->param('input_email');

    # check for errors
#   if (!$self->check_name($firstname))
#   {
#	...
#   }

    # update the mysql table
    my $table = $mgr->{Tables}->{USER};

    my $dbh = $mgr->connect(); 
    $dbh->do("LOCK TABLES $table WRITE");
    my $sth = $dbh->prepare(<<SQL);

UPDATE $table
SET email = ?
WHERE user_id = ?

SQL
    
    unless ($sth->execute($email, $mgr->{Session}->get("UserId"))) 
    {
	warn sprintf("[Error:] Trouble updating column firstname in %s. " .
		     "Reason: [%s].", $table, $dbh->errstr());
	$dbh->do("UNLOCK TABLES");
	$mgr->fatal_error("Database error.");
    }

    $dbh->do("UNLOCK TABLES");

    # now (re-)display personal page
    $self->show_pers_page($mgr);
}


#
# displays the personal information of a user
# Params: Manager ref
#
sub show_pers_page
{
    my ($self, $mgr) = @_;

    my $dbh;
    my $sth;
    my $table;        # table name for sql statements
    my $result_row;   # a row (ref) resulting from a query
    my $result_table; # an array of rows (ref of refs)

    my @lang_loop;
    my @langs = $mgr->{Func}->get_langs($mgr);

    my ($i, $j);

    # set main template vars
    $mgr->{Action} = "user";
    $mgr->{TmplData}{PAGE_TITLE} = $mgr->{Func}->get_text($mgr, 1001);
    
    # set template ifs
 #   $mgr->{TmplData}{USER_IF_NOTMYSELF} = '1';

    # set dictionary template vars
    $mgr->{TmplData}{PAGE_LANG_001001} = $mgr->{Func}->get_text($mgr, 1001);
    $mgr->{TmplData}{PAGE_LANG_001002} = $mgr->{Func}->get_text($mgr, 1002);
    $mgr->{TmplData}{PAGE_LANG_001003} = $mgr->{Func}->get_text($mgr, 1003);
    $mgr->{TmplData}{PAGE_LANG_001004} = $mgr->{Func}->get_text($mgr, 1004);
    $mgr->{TmplData}{PAGE_LANG_001005} = $mgr->{Func}->get_text($mgr, 1005);
    $mgr->{TmplData}{PAGE_LANG_001006} = $mgr->{Func}->get_text($mgr, 1006);
    $mgr->{TmplData}{PAGE_LANG_001007} = $mgr->{Func}->get_text($mgr, 1007);
    $mgr->{TmplData}{PAGE_LANG_001008} = $mgr->{Func}->get_text($mgr, 1008);
    $mgr->{TmplData}{PAGE_LANG_001013} = $mgr->{Func}->get_text($mgr, 1013);

    # get values from user table: username, name, email, points
    $table = $mgr->{Tables}->{USER};
    $dbh = $mgr->connect();

    $dbh->do("LOCK TABLES $table READ");
    $sth = $dbh->prepare(<<SQL);

SELECT username, firstname, lastname, email, points
FROM $table
WHERE user_id = ?

SQL
   
    unless ($sth->execute($mgr->{Session}->get("UserId"))) 
    {
	warn sprintf("[Error:] Trouble selecting from %s. " .
		     "Reason: [%s].", $table, $dbh->errstr());
	$dbh->do("UNLOCK TABLES");
	$mgr->fatal_error("Database error.");
    }

    $result_row = $sth->fetchrow_arrayref();
    $dbh->do("UNLOCK TABLES");
       
    $mgr->{TmplData}{USER_USERNAME}  = $result_row->[0];
    $mgr->{TmplData}{USER_FIRSTNAME} = $result_row->[1];
    $mgr->{TmplData}{USER_LASTNAME}  = $result_row->[2];
    $mgr->{TmplData}{USER_EMAIL}     = $result_row->[3];
    $mgr->{TmplData}{USER_POINTS}    = $result_row->[4];

    $sth->finish();


    # get user's languages
    $table = $mgr->{Tables}->{USER_LANG};
    $dbh->do("LOCK TABLES $table READ");
    $sth = $dbh->prepare(<<SQL);

SELECT user_id, lang_id, level
FROM $table
WHERE user_id = ?

SQL
   
    unless ($sth->execute($mgr->{Session}->get("UserId"))) 
    {
	warn sprintf("[Error:] Trouble selecting from %s. " .
		     "Reason: [%s].", $table, $dbh->errstr());
	$dbh->do("UNLOCK TABLES");
	$mgr->fatal_error("Database error.");
    }

    $result_table = $sth->fetchall_arrayref();    
    $dbh->do("UNLOCK TABLES");

    @lang_loop = ();
    $i = 0;

    foreach $result_row (@$result_table)
    {
	my %loop_row;
	my $lang_id = $result_row->[1];
	my $level   = $result_row->[2];
	
	# the language name
	$loop_row{USER_LANG} = $self->get_lang_name($mgr, $lang_id);

	# the select box name: append language index for update later on
	$loop_row{USER_SELECT_LANG} = "sel_langlvl_$lang_id";

	# now for the level select box
	for ($j = 0; $j < 5; $j++)
        {
	    $loop_row{"USER_OPTION_LANG_$j"} = $mgr->{Func}->get_text($mgr, 1014 + $j);
	}

	# make the current level the default selected
	$loop_row{"USER_DEF_LANG_$level"} = "selected";

	# the submit button name: append loop index for update later on
	$loop_row{USER_SUBMIT_LANG} = "change_langlvl_$i";
	# submit button value
	$loop_row{PAGE_LANG_001013} = $mgr->{Func}->get_text($mgr, 1013);
	
	# loop vars all set. now push ref onto loop array
	push(@lang_loop, \%loop_row);
	
	$i++;
    } # for each user language

    $sth->finish();
    $mgr->{TmplData}{USER_LOOP_LANG} = \@lang_loop;
}



#
# Returns the name of a language in the current session's lang
# Params: 1. Manager ref  2. index of language as in lingua_languages
#
sub get_lang_name {
  my ($self, $mgr, $index) = @_;

  # Get the languages table name from the current system languages.
  my $lang       = $mgr->{SystemLangs}->{$mgr->{Language}};

  my $table_dict = $mgr->{Tables}->{DICT};
  my $table_lang = $mgr->{Tables}->{LANG};
  my $dbh        = $mgr->connect();


  # select the name of the desired lang_id from dictionary
  my $sth        = $dbh->prepare(<<SQL);

SELECT l.lang_id, d.$lang
FROM   $table_dict d , $table_lang l
WHERE  l.lang_name_id = d.dict_id AND l.lang_id = $index

SQL

  unless ($sth->execute()) {
    warn sprintf("[Error:] Trouble selecting data from [%s] and [%s].".
	         "Reason: [%s].", $table_dict, $table_lang, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }

  my $result = $sth->fetchrow_arrayref()->[1];

  $sth->finish();

  return $result;
}


1;












