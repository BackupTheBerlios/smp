package modules::User;

use Class::Singleton;
use base 'Class::Singleton';
use vars qw($VERSION);
use strict;

$VERSION = sprintf "%d.%03d", q$Revision: 1.5 $ =~ /(\d+)\.(\d+)/;

#
# this method is called by the manager (main.cgi)
# Params: 1. Manager ref
# Returns true
#
sub parameter {
    my ($self, $mgr) = @_;
    my $i;

    # parse CGI to choose current method ...

    # case 1: Registration
    if (defined($mgr->{CGI}->param('method')) 
	&& $mgr->{CGI}->param('method') eq 'reg1')
    {
	# case 1.1: New registration
	unless (defined($mgr->{CGI}->param('reg_from')))
        {
	    $self->show_reg1($mgr);
	    return 1;
	}

	# case 1.2: A button was pressed on registration page 1
	if ($mgr->{CGI}->param('reg_from') eq '1')
        {
	    # go to page 2; values from page 1 are saved in hidden fields.
	    if (defined($mgr->{CGI}->param('u_sub_reg1')))
	    {
		my $username   = $mgr->{CGI}->param('u_inp_username');
		my $firstname  = $mgr->{CGI}->param('u_inp_firstname');
		my $lastname   = $mgr->{CGI}->param('u_inp_lastname');
		my $email      = $mgr->{CGI}->param('u_inp_email');
		my $syslang_id = $mgr->{CGI}->param('u_sel_syslang');

		$self->show_reg2($mgr, $username, $firstname, $lastname, $email, 
				 $syslang_id);
		return 1;
	    }
	    # stay on page 1 (language change)
	    $self->show_reg1($mgr);
	    return 1;
	}

	# case 1.3: A button was pressed on registration page 2
	if ($mgr->{CGI}->param('reg_from') eq '2')
        {
	    # get user values from hidden fields
	    my $username   = $mgr->{CGI}->param('u_username');
	    my $firstname  = $mgr->{CGI}->param('u_firstname');
	    my $lastname   = $mgr->{CGI}->param('u_lastname');
	    my $email      = $mgr->{CGI}->param('u_email');
	    my $syslang_id = $mgr->{CGI}->param('u_syslang');
	    
            # add a new user and go to page 3
	    if (defined($mgr->{CGI}->param('u_sub_reg2')))
	    {
		my ($user_id, $error) = 
		    $self->add_newuser($mgr, $username, $lastname, $email, 
				       $syslang_id);
		# if a new user could not be added, an error occured!
		# -> back to page 1
		if ($error)
	        {
		    $self->show_reg1($mgr, $error, $username, $firstname, 
				     $lastname, $email, $syslang_id);
		    return 1;
		}
		# else go on to page 3
		$self->show_reg3($mgr, $user_id);
		return 1;
	    }

	    # stay on page 2 (language change)
	    $self->show_reg2($mgr, $username, $firstname, $lastname, $email, 
			     $syslang_id);
	    return 1;
	} # reg_from == '2'

	# case 1.4: A button was pressed on registration page 3
	if ($mgr->{CGI}->param('reg_from') eq '3')
        {
	    my $user_id = $mgr->{CGI}->param('u_userid');

	    # add a language for user and go to page 4
	    if (defined($mgr->{CGI}->param('u_sub_reg3')))
	    {
		my $lang_id = $mgr->{CGI}->param('u_sel_newlang');
		my $level   = $mgr->{CGI}->param('u_sel_newlanglvl');

		my $error = $self->check_new_userid($user_id);
		if ($error)
	        {
		    $self->show_reg1($mgr, $error);
		    return 1;
		}
		$self->add_newlang($mgr, $user_id, $lang_id, $level);
		$self->show_reg4($mgr, $user_id);
		return 1;
	    }

	    # add a language and stay on page 3
	    if (defined($mgr->{CGI}->param('u_sub_reg3more')))
	    {
		my $lang_id = $mgr->{CGI}->param('u_sel_newlang');
		my $level   = $mgr->{CGI}->param('u_sel_newlanglvl');

		my $error = $self->check_new_userid($user_id);
		if ($error)
	        {
		    $self->show_reg1($mgr, $error);
		    return 1;
		}
		$self->add_newlang($mgr, $user_id, $lang_id, $level);
		$self->show_reg3($mgr, $user_id);
		return 1;
	    }

	    # stay on page 3 (language change)
	    $self->show_reg3($mgr, $user_id);
	    return 1;
	} # reg_from == '3'

	# case 1.5: A button was pressed on registration page 4
	if ($mgr->{CGI}->param('reg_from') eq '4')
        {
	    my $user_id = $mgr->{CGI}->param('u_userid');

	    # add a description and go to page 5 (finish)
	    if (defined($mgr->{CGI}->param('u_sub_reg4')))
	    {
		my $description   = $mgr->{CGI}->param('u_inp_username');
		my $lang_id = $mgr->{CGI}->param('u_sel_lang');

		my $error = $self->check_new_userid($user_id);
		if ($error)
	        {
		    $self->show_reg1($mgr, $error);
		    return 1;
		}
		$self->add_newuserdesc($mgr, $user_id, $lang_id, $description);
		$self->show_reg5($mgr, $user_id);
		return 1;
	    }

	    # add a description and stay on page 4
	    if (defined($mgr->{CGI}->param('u_sub_reg4more')))
	    {
		my $description   = $mgr->{CGI}->param('u_inp_username');
		my $lang_id = $mgr->{CGI}->param('u_sel_lang');

		my $error = $self->check_new_userid($user_id);
		if ($error)
	        {
		    $self->show_reg1($mgr, $error);
		    return 1;
		}
 		$self->add_new_desc($mgr, $user_id, $lang_id, $description);
		$self->show_reg4($mgr, $user_id);
		return 1;
	    }

	    # stay on page 4 (language change)
	    $self->show_reg4($mgr, $user_id);
	} # reg_from == '4'
    } # method == 'reg1'

#    if ($self->check_new_user_id($user_id))
#	    {
#		my $lang_id = $mgr->{CGI}->param('u_sel_newlang');
#		my $level   = $mgr->{CGI}->param('u_sel_newlanglvl');
#		$self->add_newlang($mgr, $user_id, $lang_id, $level);
#		$self->show_reg3($mgr);
#	    }
#	    else
#	    {
#		warn sprintf("[Error:] Invalid user_id %s trying to add a language", $user_id);
#		$mgr->fatal_error("An Error occured during your registration");
#	    }
#	    return 1;
#	}
#    } # method=="reg3
    
    # case 2: My personal page
    if (defined($mgr->{CGI}->param('method')) && $mgr->{CGI}->param('method') eq 'mypage')
    {
	# case 2.1: user changed his email address
	if ($mgr->{CGI}->param('u_sub_email'))
        {	
	    my $email = $mgr->{CGI}->param('u_inp_email');

	    $self->change_email($mgr, $email);
	    $self->show_mypage($mgr);
	    return 1;
	}

	# case 2.2: user changed the level of one of his languages
	my $num_langs = $mgr->{Session}->get('User_numLangs');
	for ($i = 0; $i < $num_langs; $i++)
        {
	    if ($mgr->{CGI}->param("u_sub_langlvl_$i"))
            {
		my $lang_id = $mgr->{Session}->get("User_langId_$i");
		my $level   = $mgr->{CGI}->param("u_sel_langlvl_$i");

		$self->change_langlvl($mgr, $lang_id, $level);
		$self->show_mypage($mgr);
		return 1;
	    }
	}

	# case 2.3: user added a new language for himself
	if ($mgr->{CGI}->param('u_sub_newlang'))
        {
	    my $lang_id = $mgr->{CGI}->param('u_sel_newlang');
	    my $level   = $mgr->{CGI}->param('u_sel_newlanglvl');
            my $user_id = $mgr->{Session}->get("UserId");

	    $self->add_newlang($mgr, $user_id, $lang_id, $level);
	    $self->show_mypage($mgr);
	    return 1;
	}

	# case 2.4: user changed his system language
	if ($mgr->{CGI}->param('u_sub_syslang'))
        {
	    my $lang_id = $mgr->{CGI}->param('u_sel_syslang');
	
	    $self->change_syslang($mgr, $lang_id);
	    $self->show_mypage($mgr);
	    return 1;
	}

	# case 2.5: no change (default)
	$self->show_mypage($mgr);
	return 1;
    } # method=='mypage'

    # case 3 (no cgi input): user wants to see his info page
    $self->show_mypage($mgr);
    return 1;
}



#
# adds a new user to database
# Params: 1. Manager ref
#         2. user name
#         3. first name
#         4. last name
#         5. email
#         6. system lang. id
# Returns ($user_id, $error_lang_id)
#
sub add_new_user
{
    my ($mgr, $username, $firstname, $lastname, $email, $syslang) = @_;

    return ($0, $0);
}



#
# adds a language of a new user to database
# Params: 1. Manager ref
#         2. user_id
#         3. lang_id
#         4. level
# Returns $error_lang_id
#
sub add_new_lang
{
    my ($mgr, $user_id, $lang_id, $level) = @_;

    return 0;
}



#
# adds a language of a new user to database
# Params: 1. Manager ref
#         2. user_id
#         3. lang_id
#         4. description
# Returns $error_lang_id
#
sub add_new_desc
{
    my ($mgr, $user_id, $lang_id, $description) = @_;

    return 0;
}



#
# shows the first registration page
# Params: 1. Manager ref
#         2. error lang. id (optional)
#         3. username       (optional)
#         4. firstname      (")
#         5. lastname       (")
#         6. email          (")
#         7. syslang_id     (")
# No Return value
#
sub show_reg1
{
    my ($self, $mgr, $error, $username, $firstname, $lastname, $email, 
	$syslang_id) = @_;

    my @syslang_loop;
    my @syslangs = $mgr->{Func}->get_langs($mgr, "system");
    my $syslang;

    # main templage vars
    $mgr->{Template} = $mgr->{TmplFiles}->{User_Reg1};
    $mgr->{Action} = "user";
    $mgr->{TmplData}{PAGE_TITLE} = $mgr->{Func}->get_text($mgr, 1021);
    
    # fill surrounding page
    $mgr->{Page}->fill_main_part($mgr);
    $mgr->{Page}->fill_user_part($mgr);
    $mgr->{Page}->fill_lang_part($mgr);

    # fill input fields if necessary
    $mgr->{TmplData}{USER_USERNAME}  = $username  if (defined($username));
    $mgr->{TmplData}{USER_FIRSTNAME} = $firstname if (defined($firstname));
    $mgr->{TmplData}{USER_LASTNAME}  = $lastname  if (defined($lastname));
    $mgr->{TmplData}{USER_EMAIL}     = $email     if (defined($email));
    
    # fill dictionary template vars
    $mgr->{TmplData}{PAGE_LANG_001003} = $mgr->{Func}->get_text($mgr, 1003);
    $mgr->{TmplData}{PAGE_LANG_001004} = $mgr->{Func}->get_text($mgr, 1004);
    $mgr->{TmplData}{PAGE_LANG_001005} = $mgr->{Func}->get_text($mgr, 1005);
    $mgr->{TmplData}{PAGE_LANG_001006} = $mgr->{Func}->get_text($mgr, 1006);
    $mgr->{TmplData}{PAGE_LANG_001020} = $mgr->{Func}->get_text($mgr, 1020);
    $mgr->{TmplData}{PAGE_LANG_001021} = $mgr->{Func}->get_text($mgr, 1021);
    $mgr->{TmplData}{PAGE_LANG_001022} = $mgr->{Func}->get_text($mgr, 1022);
    $mgr->{TmplData}{PAGE_LANG_001023} = $mgr->{Func}->get_text($mgr, 1023);
    $mgr->{TmplData}{PAGE_LANG_001024} = $mgr->{Func}->get_text($mgr, 1024);
    $mgr->{TmplData}{PAGE_LANG_001025} = $mgr->{Func}->get_text($mgr, 1025);
    $mgr->{TmplData}{PAGE_LANG_001028} = $mgr->{Func}->get_text($mgr, 1028);

    # fill system language select box
    foreach $syslang (@syslangs) 
    {
	my %loop_row;

	$loop_row{USER_OPTVAL_SYSLANG} = $syslang->[0];
	$loop_row{USER_OPT_SYSLANG}    = $syslang->[1];

	if (defined($syslang_id) && $syslang->[0] == $syslang_id)
        {
	    $loop_row{USER_DEF_SYSLANG} = "selected";
	}

	# loop vars all set. now push ref onto loop array
	push(@syslang_loop, \%loop_row);
    }

    $mgr->{TmplData}{USER_LOOP_SYSLANG} = \@syslang_loop;
}



#
# shows the second registration page
# Params: 1. Manager ref
#         2. username
#         3. firstname
#         4. lastname
#         5. email
#         6. syslang_id
# No Return value
#
sub show_reg2
{
    my ($self, $mgr, $username, $firstname, $lastname, $email, 
	$syslang_id) = @_;

    # main templage vars
    $mgr->{Template} = $mgr->{TmplFiles}->{User_Reg2};
    $mgr->{Action} = "user";
    $mgr->{TmplData}{PAGE_TITLE} = $mgr->{Func}->get_text($mgr, 1021);
    
    # fill surrounding page
    $mgr->{Page}->fill_main_part($mgr);
    $mgr->{Page}->fill_user_part($mgr);
    $mgr->{Page}->fill_lang_part($mgr);

    # fill user values (and also the hidden fields)
    $mgr->{TmplData}{USER_USERNAME}  = $username;
    $mgr->{TmplData}{USER_FIRSTNAME} = $firstname;
    $mgr->{TmplData}{USER_LASTNAME}  = $lastname;
    $mgr->{TmplData}{USER_EMAIL}     = $email;
    $mgr->{TmplData}{USER_SYSLANGID} = $syslang_id;
    $mgr->{TmplData}{USER_SYSLANG}   = $self->get_lang_name($mgr, $syslang_id);
    
    # fill dictionary template vars
    $mgr->{TmplData}{PAGE_LANG_001003} = $mgr->{Func}->get_text($mgr, 1003);
    $mgr->{TmplData}{PAGE_LANG_001004} = $mgr->{Func}->get_text($mgr, 1004);
    $mgr->{TmplData}{PAGE_LANG_001005} = $mgr->{Func}->get_text($mgr, 1005);
    $mgr->{TmplData}{PAGE_LANG_001006} = $mgr->{Func}->get_text($mgr, 1006);
    $mgr->{TmplData}{PAGE_LANG_001020} = $mgr->{Func}->get_text($mgr, 1020);
    $mgr->{TmplData}{PAGE_LANG_001028} = $mgr->{Func}->get_text($mgr, 1028);
    $mgr->{TmplData}{PAGE_LANG_001030} = $mgr->{Func}->get_text($mgr, 1030);
    $mgr->{TmplData}{PAGE_LANG_001031} = $mgr->{Func}->get_text($mgr, 1031);    
    $mgr->{TmplData}{PAGE_LANG_001032} = $mgr->{Func}->get_text($mgr, 1032);
    $mgr->{TmplData}{PAGE_LANG_001033} = $mgr->{Func}->get_text($mgr, 1033);
}



#
# updates user table upon change of email address
# Params: 1. Manager ref
# No Return value
#
sub change_email
{
    my ($self, $mgr, $email) = @_;

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
}



#
# updates user table upon change of email address and calls show_pers_page again
# Params: 1. Manager ref  
#         2. language index  
#         3. level (0-4)
# No Return value
#
sub change_langlvl
{
    my ($self, $mgr, $lang_id, $level) = @_;

    my $dbh = $mgr->connect();
    my $sth;
    my $table;        # table name for sql statements
    my $sql_return;   # return value from sql statement

    $table = $mgr->{Tables}->{USER_LANG};
    $dbh->do("LOCK TABLES $table WRITE");

    # a level between 0 and 4 is a 'normal' level
    if ($level <= 4) 
    {
	$sth = $dbh->prepare(<<SQL);

UPDATE $table
SET level = ?
WHERE user_id = ? AND lang_id = ?

SQL

        $sql_return = $sth->execute($level, $mgr->{Session}->get("UserId"), $lang_id);
    }

    # level = 5 means 'delete this user language'
    elsif ($level == 5)
    {
	$sth = $dbh->prepare(<<SQL);

DELETE FROM $table
WHERE user_id = ? AND lang_id = ?

SQL
        $sql_return = $sth->execute($mgr->{Session}->get("UserId"), $lang_id);
    }

    # level > 5: something got messed up (no worry here)
    else
    {
	$dbh->do("UNLOCK TABLES");
	return;
    }

    # check for mysql error
    unless ($sql_return) 
    {
	warn sprintf("[Error:] Trouble updating %s. " .
		     "Reason: [%s].", $table, $dbh->errstr());
	$dbh->do("UNLOCK TABLES");
	$mgr->fatal_error("Database error.");
    }

    $dbh->do("UNLOCK TABLES");
    $sth->finish();
}



#
# adds a language to user lang table
# Params: 1. Manager ref  
#         2. User ID
#         3. language index  
#         4. level (0-4)
# No Return value
#
sub add_newlang
{
    my ($self, $mgr, $user_id, $lang_id, $level) = @_;

    my $dbh = $mgr->connect();
    my $sth;
    my $table;        # table name for sql statements
    my $result_row;   # a row (ref) resulting from a query

    # first check whether this entry exists already
    $table = $mgr->{Tables}->{USER_LANG};
    $dbh->do("LOCK TABLES $table READ");
    $sth = $dbh->prepare(<<SQL);

SELECT user_id, lang_id 
FROM $table
WHERE user_id = ? AND lang_id = ?

SQL

    unless ($sth->execute($user_id, $lang_id)) 
    {
	warn sprintf("[Error:] Trouble updating %s. " .
		     "Reason: [%s].", $table, $dbh->errstr());
	$dbh->do("UNLOCK TABLES");
	$mgr->fatal_error("Database error.");
    }

    $dbh->do("UNLOCK TABLES");

    # if user has this language, just change its level
    if ($sth->fetchrow_array())
    {
	$sth->finish();
	$self->change_langlvl($mgr, $lang_id, $level);
	return;
    }

    # else add new language
    $sth->finish();
    $dbh->do("LOCK TABLES $table WRITE");
    $sth = $dbh->prepare(<<SQL);

INSERT INTO $table (user_id, lang_id, level)
VALUES (?, ?, ?)

SQL

    unless ($sth->execute($user_id, $lang_id, $level)) 
    {
	warn sprintf("[Error:] Trouble updating %s. " .
		     "Reason: [%s].", $table, $dbh->errstr());
	$dbh->do("UNLOCK TABLES");
	$mgr->fatal_error("Database error.");
    }

    $dbh->do("UNLOCK TABLES");    
}



#
# changes a user's system language (does not verify whether lang_id really is a 
#                                   syslang!)
# Params: 1. Manager ref
#         2. lang_id
# No Return value
#
sub change_syslang
{
    my ($self, $mgr, $lang_id) = @_;

    my $dbh = $mgr->connect();
    my $sth;
    my $table;        # table name for sql statements
    my $sql_return;   # return value from sql statement

    $table = $mgr->{Tables}->{USER};
    $dbh->do("LOCK TABLES $table WRITE");

    $sth = $dbh->prepare(<<SQL);

UPDATE $table
SET system_lang = ?
WHERE user_id = ?

SQL

    # execute sql statement
    unless ($sth->execute($lang_id, $mgr->{Session}->get("UserId")))
    {
	warn sprintf("[Error:] Trouble updating %s. " .
		     "Reason: [%s].", $table, $dbh->errstr());
	$dbh->do("UNLOCK TABLES");
	$mgr->fatal_error("Database error.");
    }

    $dbh->do("UNLOCK TABLES");
    $sth->finish();
}



#
# displays the personal information of a user to himself
# Params: 1. Manager ref 
# No Return value
#
sub show_mypage
{
    my ($self, $mgr) = @_;

    my $dbh = $mgr->connect;
    my $sth;
    my $table;        # table name for sql statements
    my $result_row;   # a row (ref) resulting from a query
    my $result_table; # an array of rows (ref of refs)

    my @lang_loop;
    my @syslang_loop;
    my @syslangs = $mgr->{Func}->get_langs($mgr, "system");
    my $syslang;
    my $syslang_id;
    my @langs    = $mgr->{Func}->get_langs($mgr);
    my $lang;
    my @newlang_loop;

    my ($i, $j);

    # set main template vars
    #---------------------------------------------------------------------------
    $mgr->{Template} = $mgr->{TmplFiles}->{User_MyPage};
    $mgr->{Action} = "user";
    $mgr->{TmplData}{PAGE_TITLE} = $mgr->{Func}->get_text($mgr, 1001);
    
    # fill surrounding page
    $mgr->{Page}->fill_main_part($mgr);
    $mgr->{Page}->fill_user_part($mgr);
    $mgr->{Page}->fill_lang_part($mgr);

    # set dictionary template vars
    $mgr->{TmplData}{PAGE_LANG_001001} = $mgr->{Func}->get_text($mgr, 1001);
    $mgr->{TmplData}{PAGE_LANG_001002} = $mgr->{Func}->get_text($mgr, 1002);
    $mgr->{TmplData}{PAGE_LANG_001004} = $mgr->{Func}->get_text($mgr, 1004);
    $mgr->{TmplData}{PAGE_LANG_001005} = $mgr->{Func}->get_text($mgr, 1005);
    $mgr->{TmplData}{PAGE_LANG_001006} = $mgr->{Func}->get_text($mgr, 1006);
    $mgr->{TmplData}{PAGE_LANG_001008} = $mgr->{Func}->get_text($mgr, 1008);
    $mgr->{TmplData}{PAGE_LANG_001010} = $mgr->{Func}->get_text($mgr, 1010);
    $mgr->{TmplData}{PAGE_LANG_001013} = $mgr->{Func}->get_text($mgr, 1013);
    $mgr->{TmplData}{PAGE_LANG_001020} = $mgr->{Func}->get_text($mgr, 1020);


    # Part 1: name, email
    #---------------------------------------------------------------------------
    # get values from user table: username, name, email, points
    $table = $mgr->{Tables}->{USER};
    $dbh->do("LOCK TABLES $table READ");
    $sth = $dbh->prepare(<<SQL);

SELECT firstname, lastname, email, system_lang
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
       
    $mgr->{TmplData}{USER_FIRSTNAME} = $result_row->[0];
    $mgr->{TmplData}{USER_LASTNAME}  = $result_row->[1];
    $mgr->{TmplData}{USER_EMAIL}     = $result_row->[2];
    $syslang_id                      = $result_row->[3];

    $sth->finish();


    # Part 2: Languages
    #---------------------------------------------------------------------------
    # 2.1: Spoken Languages
    #---------------------------------------------------------------------------
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

	# save language index in Session for update later on
	$mgr->{Session}->set("User_langId_$i" => $lang_id);
	
	# the language name
	$loop_row{USER_MYLANG} = $self->get_lang_name($mgr, $lang_id);

	# the select box name: append loop index for update later on
	$loop_row{USER_SEL_LANGLVL} = "u_sel_langlvl_$i";

	# now for the level select box
	for ($j = 0; $j < 6; $j++)
        {
	    $loop_row{"USER_OPT_LANGLVL_$j"} = $mgr->{Func}->get_text($mgr, 1014 + $j);
	}

	# make the current level the default selected
	$loop_row{"USER_DEF_LANGLVL_$level"} = "selected";

	# the submit button name: append loop index for update later on
	$loop_row{USER_SUB_LANGLVL} = "u_sub_langlvl_$i";
	# submit button value
	$loop_row{PAGE_LANG_001013} = $mgr->{Func}->get_text($mgr, 1013);
	
	# loop vars all set. now push ref onto loop array
	push(@lang_loop, \%loop_row);
	
	$i++;
    } # for each user language

    # last not least save number of languages in session (as you may or may not 
    #   have guessed, this in case of an update by the user)
    $mgr->{Session}->set(User_numLangs => $i);

    $sth->finish();
    $mgr->{TmplData}{USER_LOOP_LANGLVL} = \@lang_loop;


    # 2.2: System Language
    #---------------------------------------------------------------------------    
    foreach $syslang (@syslangs) 
    {
	my %loop_row;

	$loop_row{USER_OPTVAL_SYSLANG} = $syslang->[0];
	$loop_row{USER_OPT_SYSLANG}    = $syslang->[1];

	if ($syslang->[0] == $syslang_id)
        {
	    $loop_row{USER_DEF_SYSLANG} = "selected";
	}

	# loop vars all set. now push ref onto loop array
	push(@syslang_loop, \%loop_row);
    }

    $mgr->{TmplData}{USER_LOOP_SYSLANG} = \@syslang_loop;


    # 2.3: New Language
    #---------------------------------------------------------------------------    
    foreach $lang (@langs)
    {
	my %loop_row;
	
	$loop_row{USER_OPTVAL_NEWLANG} = $lang->[0];
	$loop_row{USER_OPT_NEWLANG}    = $lang->[1];

	push(@newlang_loop, \%loop_row);
    }

    $mgr->{TmplData}{USER_LOOP_NEWLANG}  = \@newlang_loop;
    $mgr->{TmplData}{USER_OPT_LANGLVL_0} =  $mgr->{Func}->get_text($mgr, 1014);
    $mgr->{TmplData}{USER_OPT_LANGLVL_1} =  $mgr->{Func}->get_text($mgr, 1015);
    $mgr->{TmplData}{USER_OPT_LANGLVL_2} =  $mgr->{Func}->get_text($mgr, 1016);
    $mgr->{TmplData}{USER_OPT_LANGLVL_3} =  $mgr->{Func}->get_text($mgr, 1017);
    $mgr->{TmplData}{USER_OPT_LANGLVL_4} =  $mgr->{Func}->get_text($mgr, 1018);
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












