package modules::User;

use Class::Singleton;
use base 'Class::Singleton';
#use Mail::Sendmail;
use vars qw($VERSION);
use strict;

$VERSION = sprintf "%d.%03d", q$Revision: 1.11 $ =~ /(\d+)\.(\d+)/;

#
# this method is called by the manager (main.cgi)
# Params: 1. Manager ref
# Returns true
#
sub parameter 
{
    my ($self, $mgr) = @_;
    my $i;
    my $method = $mgr->{CGI}->param('method');

    # no method supplied by CGI? Error!
    unless (defined($method))
    {
	warn sprintf("[Error:] User module: Missing \'method\' CGI-parameter");
	$mgr->fatal_error("No method parameter in CGI!");
	return 1;
    }
	
    # case 1.1: Registration page 1
    if ($method eq 'reg1')           { $self->method_reg1($mgr); }
    # case 1.2: Registration page 2
    elsif ($method eq 'reg2')        { $self->method_reg2($mgr); }
    # case 1.3: Registration page 3
    elsif ($method eq 'reg3')        { $self->method_reg3($mgr); }
    # case 1.4: Language change on reg. page 3
    elsif ($method eq 'reg4')        { $self->method_reg4($mgr); }

    # case 2.1: personal page of a user himself
    elsif ($method eq 'mypage')      { $self->method_mypage($mgr); }
    # case 2.2: update of personal info
    elsif ($method eq 'mypage_upd')  { $self->method_mypage_upd($mgr); }
    # case 2.3: update password
    elsif ($method eq 'upd_passwd')  { $self->method_upd_passwd($mgr); }
    # case 2.4: update own system language
    elsif ($method eq 'upd_syslang') { $self->method_upd_syslang($mgr); }
    # case 2.5: edit languages
    elsif ($method eq 'upd_langs')   { $self->method_upd_langs($mgr); }
    # case 2.6: edit a personal description
    elsif ($method eq 'upd_descedit'){ $self->method_upd_descedit($mgr); }
    # case 2.7: submit a new personal description
    elsif ($method eq 'upd_descnew') { $self->method_upd_descnew($mgr); }

    # case 3: personal page of someone else
    elsif ($method eq 'otherspage')  { $self->method_otherspage($mgr); }

    # case 4.1: admin user search page
    elsif ($method eq 'adm_search')  { $self->method_adm_search($mgr); }
    # case 4.2: user-admin page
    elsif ($method eq 'admin')       { $self->method_admin($mgr); }

    return 1;
}

### METHOD HANDLERS ############################################################

sub method_reg1
{
    my ($self, $mgr) = @_;
    
    # not much to do in 'reg1' case xcept to show first registration page
    $self->show_reg1($mgr);
}


sub method_reg2
{
    my ($self, $mgr) = @_;
    my $error;
    
    # get user data from CGI
    my $username   = $mgr->{CGI}->param('u_inp_username');
    my $firstname  = $mgr->{CGI}->param('u_inp_firstname');
    my $lastname   = $mgr->{CGI}->param('u_inp_lastname');
    my $email      = $mgr->{CGI}->param('u_inp_email');
    my $syslang_id = $mgr->{CGI}->param('u_sel_syslang');

    # case 1: user pressed 'next' button on reg1 page 
    #  -> check for error; 
    #     if there are no errors, go to reg2 page, else back to reg1
    if (defined($mgr->{CGI}->param('u_sub_reg1')))
    {
	$error = $self->check_reg($mgr, $username, $firstname, $lastname, 
				  $email, $syslang_id);
        if ($error != 0) 
        {
	    $self->show_reg1($mgr, $username, $firstname, $lastname, $email, 
			     $syslang_id, $error);
	}
	else
        { 
	    $self->show_reg2($mgr, $username, $firstname, $lastname, $email, 
			     $syslang_id);
	}
    }
    # other cases (language change): stay on reg1 page
    else
    {
	$self->show_reg1($mgr, $username, $firstname, $lastname, $email, 
			 $syslang_id);
    }
}


sub method_reg3
{
    my ($self, $mgr) = @_;

    # get values from CGI 
    my $username   = $mgr->{CGI}->param('u_username');
    my $firstname  = $mgr->{CGI}->param('u_firstname');
    my $lastname   = $mgr->{CGI}->param('u_lastname');
    my $email      = $mgr->{CGI}->param('u_email');
    my $syslang_id = $mgr->{CGI}->param('u_syslang');

    # case 1: user pressed 'next' button on reg2 page 
    #  -> add user to database 
    #     and go to final reg. page
    if (defined($mgr->{CGI}->param('u_sub_reg2')))
    {
	$self->add_user($mgr, $username, $firstname, $lastname, $email, 
			$syslang_id);
	$self->show_reg3($mgr);
    }
    # other cases (language change): stay on reg2 page
    else
    {
	$self->show_reg2($mgr, $username, $firstname, $lastname, $email,
			 $syslang_id);
    }
}


#
# just in case someone changes language on final registration page
# 
sub method_reg4
{
    my ($self, $mgr) = @_;
    
    $self->show_reg3($mgr);
}


sub method_mypage
{
    my ($self, $mgr) = @_;

    # just display user's personal page
    $self->show_mypage($mgr);
}


sub method_mypage_upd
{
    my ($self, $mgr) = @_;
    
    if (defined($mgr->{CGI}->param('u_sub_passwd')))
    {
        $self->show_upd_passwd($mgr);
    }
    elsif (defined($mgr->{CGI}->param('u_sub_syslang')))
    {
        $self->show_upd_syslang($mgr);
    }
    elsif (defined($mgr->{CGI}->param('u_sub_langs')))
    {
        $self->show_upd_langs($mgr);
    }
    elsif (defined($mgr->{CGI}->param('u_sub_descchange')))
    {
	my $lang_id = $mgr->{CGI}->param('u_sel_desclang');
	# save this lang_id in session
	$mgr->{Session}->set(UserDescLangId => $lang_id);
	$self->show_mypage($mgr);
    }
    elsif (defined($mgr->{CGI}->param('u_sub_descnew')))
    {
        $self->show_upd_descnew($mgr);
    }
    elsif (defined($mgr->{CGI}->param('u_sub_descedit')))
    {
	my $lang_id = $mgr->{CGI}->param('u_desclang');
	# save this lang_id in session
	$mgr->{Session}->set(UserDescLangId => $lang_id);
        $self->show_upd_descedit($mgr);
    }
    else
    {
	$self->show_mypage($mgr);
    }
}


sub method_upd_passwd
{
    my ($self, $mgr) = @_;

    # 1. user submitted a new password
    if (defined($mgr->{CGI}->param('u_sub_passwd')))
    {
	my $passwd1 = $mgr->{CGI}->param('u_inp_passwd1');
	my $passwd2 = $mgr->{CGI}->param('u_inp_passwd2');

	my $error = $self->check_passwd($mgr, $passwd1, $passwd2);
	if ($error != 0)
        {
	    $self->show_upd_passwd($mgr, $error);
	}
	else
        {
	    my $user_id = $mgr->{Session}->get('UserId');
	    $self->upd_passwd($mgr, $user_id, $passwd1);
	    $self->show_passwd_ok($mgr);
	}
    }
    # 2. language change
    else
    {
	$self->show_upd_passwd($mgr);
    }
}


sub method_upd_syslang
{
    my ($self, $mgr) = @_;

    if (defined($mgr->{CGI}->param('u_sub_syslang')))
    {
	my $lang_id = $mgr->{CGI}->param('u_sel_syslang');
	my $user_id = $mgr->{Session}->get("UserId");
	$self->upd_syslang($mgr, $user_id, $lang_id);
	$self->show_mypage($mgr);
    }
    # in case of language change...
    else
    {
	$self->show_upd_syslang($mgr);
    }
}


sub method_upd_langs
{
    my ($self, $mgr) = @_;
    my $user_id = $mgr->{Session}->get('UserId');

    # 1. user pressed 'back' button
    if (defined($mgr->{CGI}->param('u_sub_back')))
    {
	$self->show_mypage($mgr);
	return;
    }

    # 2. user submitted a new language
    if (defined($mgr->{CGI}->param('u_sub_newlang')))
    {
	my $lang_id = $mgr->{CGI}->param('u_sel_newlang');
	my $level   = $mgr->{CGI}->param('u_sel_newlanglvl');
	$self->add_newlang($mgr, $user_id, $lang_id, $level);
	$self->show_upd_langs($mgr);
	return;
    }
    
    # 3. user changed the level of an old language
    my $numlangs = $mgr->{Session}->get('User_NumLangs');
    for (my $i = 0; $i < $numlangs; $i++)
    {
	if (defined($mgr->{CGI}->param("u_sub_langlvl_$i")))
        {
	    my $lang_id = $mgr->{Session}->get("User_LangId_$i");
	    my $level   = $mgr->{CGI}->param("u_sel_langlvl_$i");

	    $self->upd_langlvl($mgr, $user_id, $lang_id, $level);
	    $self->show_upd_langs($mgr);
	    return;
	}
    }
	
    # 3. in case of language change...
    $self->show_upd_langs($mgr);
}


sub method_upd_descedit
{
    my ($self, $mgr) = @_;

    # 1. user changed language of description
    if (defined($mgr->{CGI}->param('u_sub_desclang')))
    {
	my $lang_id = $mgr->{CGI}->param('u_sel_desclang');
	# save this lang_id in session
	$mgr->{Session}->set(UserDescLangId => $lang_id);
	$self->show_upd_descedit($mgr);
    }

    # 2. user submitted the description
    elsif (defined($mgr->{CGI}->param('u_sub_desc')))
    {
	my $lang_id = $mgr->{Session}->get('UserDescLangId');
	my $desc    = $mgr->{CGI}->param('u_inp_desc');
	my $error   = $self->check_desc($mgr, $desc);

	if ($error != 0)
        {
	    $self->show_upd_descedit($mgr, $error);
	}
	else
        {
	    my $user_id = $mgr->{Session}->get('UserId');
	    $self->upd_desc($mgr, $user_id, $lang_id, $desc);
	    $self->show_upd_descedit($mgr);
	}
    }

    # 3. back to personal page
    elsif (defined($mgr->{CGI}->param('u_sub_back')))
    {
	$self->show_mypage($mgr);
    }
    
    # 4. language change
    else
    {
	$self->show_upd_descedit($mgr);
    }
}


sub method_upd_descnew
{
    my ($self, $mgr) = @_;

    # 1. user submitted the description
    if (defined($mgr->{CGI}->param('u_sub_desc')))
    {
	my $lang_id = $mgr->{CGI}->param('u_sel_desclang');
	my $desc    = $mgr->{CGI}->param('u_inp_desc');
	my $error   = $self->check_desc($mgr, $desc);

	if ($error != 0)
        {
	    $self->show_upd_descnew($mgr, $error);
	}
	else
        {
	    # save desc language in Session...
	    $mgr->{Session}->set(UserDescLangId => $lang_id);
	    # add the description to database
	    my $user_id = $mgr->{Session}->get('UserId');
	    $self->upd_desc($mgr, $user_id, $lang_id, $desc);
	    $self->show_mypage($mgr);
	}
    }
    # 2. language change
    else
    {
	$self->show_upd_descnew($mgr);
    }
}


sub method_otherspage
{
    my ($self, $mgr) = @_;  
    my $user_id = $mgr->{CGI}->param('user_id');

    if (!defined($user_id))
    {
	warn sprintf("[Error:] No user_id given for other\'s page.");
	$mgr->fatal_error("User module error.");
	$user_id = 1;
    }

    if (defined($mgr->{CGI}->param('u_sub_descchange')))
    {
	my $lang_id = $mgr->{CGI}->param('u_sel_desclang');
	# save this lang_id in session
	$mgr->{Session}->set(UserDescLangId => $lang_id);
    }

    # just display some other user's info page
    $self->show_mypage($mgr, 'other', $user_id);
}


sub method_adm_search
{
    my ($self, $mgr) = @_;    
    my $username = $mgr->{CGI}->param('u_inp_username');

    # check if 'next' button was pressed
    if (defined($mgr->{CGI}->param('u_sub_user')))
    {
	# if username is not valid or user exists, display an error msg
	my ($user_id, $error) = $self->check_user_search($mgr, $username);
	if ($error != 0)
        {
	    $self->show_adm_search($mgr, $username, $error);
	}
	# else show this user's admin page
	else
        {
	    # save user id in session
	    $mgr->{Session}->set(User_AdmUserId => $user_id);
	    $self->show_admin_page($mgr, $user_id);
	}
    }
    # if not, just (re-)display search page
    else
    {
	$self->show_adm_search($mgr, $username);
    }
}


sub method_admin
{
    my ($self, $mgr) = @_;
    my $user_id = $mgr->{Session}->get('User_AdmUserId');

    # go to personal info page of user
    if (defined($mgr->{CGI}->param('u_sub_info')))
    {
	$self->show_mypage($mgr, 'other', $user_id);
    }
    # search for other user
    elsif (defined($mgr->{CGI}->param('u_sub_newuser')))
    {
	$self->show_adm_search($mgr);
    }
    # promote a user
    elsif (defined($mgr->{CGI}->param('u_sub_level')))
    {
	my $level = $mgr->{CGI}->param('u_sel_level');
	$self->upd_level($mgr, $user_id, $level);
    }
    # block a user
    elsif (defined($mgr->{CGI}->param('u_sub_block')))
    {
	$self->show_block_page($mgr, $user_id);
    }
    # language change
    else
    {
	$self->show_admin_page($mgr, $user_id);
    }
}

### PAGE DISPLAY FUNCTIONS #####################################################

#
# shows the first registration page
# Params: 1. Manager ref
#         2. user name
#         3. first name
#         4. last name
#         5. email
#         6. system lang. id
#         7. error lang_id (optional)
# No Return value
#
sub show_reg1
{
    my ($self, $mgr, $username, $firstname, $lastname, $email, $syslang_id, 
	$error) = @_;
  
    # main templage vars
    $mgr->{Template} = $mgr->{TmplFiles}->{User_Reg1};
    $mgr->{Action} = "user";
    $mgr->{TmplData}{PAGE_TITLE}  = $mgr->{Func}->get_text($mgr, 1010);
    $mgr->{TmplData}{PAGE_METHOD} = 'reg2';
    
    # fill input fields if necessary
    $mgr->{TmplData}{USER_USERNAME}  = $username  if (defined($username));
    $mgr->{TmplData}{USER_FIRSTNAME} = $firstname if (defined($firstname));
    $mgr->{TmplData}{USER_LASTNAME}  = $lastname  if (defined($lastname));
    $mgr->{TmplData}{USER_EMAIL}     = $email     if (defined($email));

    # fill system language select box
    my @syslangs = $mgr->{Func}->get_langs($mgr, 'system');
    $self->fill_lang_select($mgr, \@syslangs, undef, $syslang_id);
    
    # fill dictionary template vars
    $mgr->{TmplData}{PAGE_LANG_001010} = $mgr->{Func}->get_text($mgr, 1010);
    $mgr->{TmplData}{PAGE_LANG_001011} = $mgr->{Func}->get_text($mgr, 1011);
    $mgr->{TmplData}{PAGE_LANG_001012} = $mgr->{Func}->get_text($mgr, 1012);
    $mgr->{TmplData}{PAGE_LANG_001013} = $mgr->{Func}->get_text($mgr, 1013);
    $mgr->{TmplData}{PAGE_LANG_001014} = $mgr->{Func}->get_text($mgr, 1014);
    $mgr->{TmplData}{PAGE_LANG_001015} = $mgr->{Func}->get_text($mgr, 1015);
    $mgr->{TmplData}{PAGE_LANG_001016} = $mgr->{Func}->get_text($mgr, 1016);
    $mgr->{TmplData}{PAGE_LANG_001017} = $mgr->{Func}->get_text($mgr, 1017);
    $mgr->{TmplData}{PAGE_LANG_001018} = $mgr->{Func}->get_text($mgr, 1018);
    $mgr->{TmplData}{PAGE_LANG_001019} = $mgr->{Func}->get_text($mgr, 1019);
    $mgr->{TmplData}{PAGE_LANG_001020} = $mgr->{Func}->get_text($mgr, 1020);
    $mgr->{TmplData}{PAGE_LANG_001021} = $mgr->{Func}->get_text($mgr, 1021);

    # show error message if necessary
    if (defined($error))
    {
	$mgr->{TmplData}{USER_IF_REG1_ERR} = 1;
	$mgr->{TmplData}{PAGE_LANG_001023} = $mgr->{Func}->get_text($mgr, 1023);
	$mgr->{TmplData}{USER_ERROR_REG1} = $mgr->{Func}->get_text($mgr, $error);
    }	
}


#
# shows the second registration page
# Params: 1. Manager ref
#         2. user name
#         3. first name
#         4. last name
#         5. email
#         6. system lang. id
# No Return value
#
sub show_reg2
{
    my ($self, $mgr, $username, $firstname, $lastname, $email, 
	$syslang_id) = @_;

    # main templage vars
    $mgr->{Template} = $mgr->{TmplFiles}->{User_Reg2};
    $mgr->{Action} = "user";
    $mgr->{TmplData}{PAGE_TITLE} = $mgr->{Func}->get_text($mgr, 1031);
    $mgr->{TmplData}{PAGE_METHOD} = 'reg3';
    
    # fill user values (and also the hidden fields)
    $mgr->{TmplData}{USER_USERNAME}  = $username   if (defined($username));
    $mgr->{TmplData}{USER_FIRSTNAME} = $firstname  if (defined($firstname));
    $mgr->{TmplData}{USER_LASTNAME}  = $lastname   if (defined($lastname));
    $mgr->{TmplData}{USER_EMAIL}     = $email      if (defined($email));
    $mgr->{TmplData}{USER_SYSLANGID} = $syslang_id if (defined($syslang_id));
    if (defined($syslang_id))
    {
	$mgr->{TmplData}{USER_SYSLANG} 
	    = $self->get_lang_name($mgr, $syslang_id);
    }
    
    # fill dictionary template vars
    $mgr->{TmplData}{PAGE_LANG_001031} = $mgr->{Func}->get_text($mgr, 1031);
    $mgr->{TmplData}{PAGE_LANG_001032} = $mgr->{Func}->get_text($mgr, 1032);
    $mgr->{TmplData}{PAGE_LANG_001033} = $mgr->{Func}->get_text($mgr, 1033);
    $mgr->{TmplData}{PAGE_LANG_001034} = $mgr->{Func}->get_text($mgr, 1034);
    $mgr->{TmplData}{PAGE_LANG_001035} = $mgr->{Func}->get_text($mgr, 1035);
    $mgr->{TmplData}{PAGE_LANG_001036} = $mgr->{Func}->get_text($mgr, 1036);
    $mgr->{TmplData}{PAGE_LANG_001037} = $mgr->{Func}->get_text($mgr, 1037);
    $mgr->{TmplData}{PAGE_LANG_001038} = $mgr->{Func}->get_text($mgr, 1038);
    $mgr->{TmplData}{PAGE_LANG_001039} = $mgr->{Func}->get_text($mgr, 1039);
    $mgr->{TmplData}{PAGE_LANG_001040} = $mgr->{Func}->get_text($mgr, 1040);
}


#
# shows the final registration page
# Params: 1. Manager ref
# No Return value
#
sub show_reg3
{
    my ($self, $mgr) = @_;

    # main templage vars
    $mgr->{Template} = $mgr->{TmplFiles}->{User_Reg3};
    $mgr->{Action} = "user";
    $mgr->{TmplData}{PAGE_TITLE} = $mgr->{Func}->get_text($mgr, 1043);
    $mgr->{TmplData}{PAGE_METHOD} = 'reg4';
    
    # fill dictionary template vars
    $mgr->{TmplData}{PAGE_LANG_001043} = $mgr->{Func}->get_text($mgr, 1043);
    $mgr->{TmplData}{PAGE_LANG_001044} = $mgr->{Func}->get_text($mgr, 1044);
    $mgr->{TmplData}{PAGE_LANG_001045} = $mgr->{Func}->get_text($mgr, 1045);
    $mgr->{TmplData}{PAGE_LANG_001046} = $mgr->{Func}->get_text($mgr, 1046);
    $mgr->{TmplData}{PAGE_LANG_001047} = $mgr->{Func}->get_text($mgr, 1047);
    $mgr->{TmplData}{PAGE_LANG_001048} = $mgr->{Func}->get_text($mgr, 1048);
}


#
# shows the personal page
# Params: 1. Manager ref.
#         2. mode ('me' or 'other') (optional; leaving blank means 'me')
#         3. user id  (optional; only needed when mode eq 'other', but 
#                      then required)
# No Return value 
#
sub show_mypage
{
    my ($self, $mgr, $mode, $user_id) = @_;

    #--- get data ------------------------------------------------------------#
    if (not defined($mode) or $mode eq 'me')
    {
	$user_id  = $mgr->{Session}->get("UserId");
    }

    my ($username, $firstname, $lastname, $email, $syslang_id, $lasttime, 
	$regtime, $level, $status) = $self->get_user_info($mgr, $user_id);

    # get user's languages (ids) and levels (1-5) from db in a 2-d-array
    my $mylangs = $self->get_mylangs_and_levels($mgr, $user_id);

    # get language id of description from session (if set before)
    my $desc_langid = $mgr->{Session}->get('UserDescLangId');

    # get languages of all descriptions by this user
    my $desclangs = $self->get_desclangs($mgr, $user_id);

    # get user's description (in desired language, if exists, else in current 
    #   syslang, else in any other.
    my $desc;
    ($desc, $desc_langid)
        = $self->get_desc($mgr, $user_id, $desc_langid, $desclangs);
       
    #--- fill user part ------------------------------------------------------#
    # main template vars
    $mgr->{Template} = $mgr->{TmplFiles}->{User_MyPage};
    $mgr->{Action} = "user";
    $mgr->{TmplData}{PAGE_TITLE}
        = $mgr->{Func}->get_text($mgr, 1051) . " " . $username;

    # dictionary entries
    $mgr->{TmplData}{PAGE_LANG_001051} = $mgr->{Func}->get_text($mgr, 1051);
    $mgr->{TmplData}{PAGE_LANG_001052} = $mgr->{Func}->get_text($mgr, 1052);
    $mgr->{TmplData}{PAGE_LANG_001053} = $mgr->{Func}->get_text($mgr, 1053);
    $mgr->{TmplData}{PAGE_LANG_001054} = $mgr->{Func}->get_text($mgr, 1054);
    $mgr->{TmplData}{PAGE_LANG_001056} = $mgr->{Func}->get_text($mgr, 1056);
    $mgr->{TmplData}{PAGE_LANG_001057} = $mgr->{Func}->get_text($mgr, 1057);
    $mgr->{TmplData}{PAGE_LANG_001058} = $mgr->{Func}->get_text($mgr, 1058);
    $mgr->{TmplData}{PAGE_LANG_001077} = $mgr->{Func}->get_text($mgr, 1077);

    # user data in template
    $mgr->{TmplData}{USER_USERNAME}  = $username;
    $mgr->{TmplData}{USER_FIRSTNAME} = $firstname;
    $mgr->{TmplData}{USER_LASTNAME}  = $lastname;
    $mgr->{TmplData}{USER_EMAIL}     = $email;
    $mgr->{TmplData}{USER_SYSLANG}   = $self->get_lang_name($mgr, $syslang_id);
    $mgr->{TmplData}{USER_LEVEL}     
        = $mgr->{Func}->get_text($mgr, 1088 + $level);
    if (defined($lasttime))
    {
	$mgr->{TmplData}{USER_LASTLOGIN} = $self->timestring($lasttime);
    }
    $mgr->{TmplData}{USER_REGTIME}   = $self->timestring($regtime);

# !!!
# handle status here!!
# !!!

    #--- fill language part --------------------------------------------------#
    if (@$mylangs == 0)
    {
	$mgr->{TmplData}{PAGE_LANG_001075} = $mgr->{Func}->get_text($mgr, 1075);
    }
    else
    {
	my @loop;
	my $lang;
	foreach $lang (@$mylangs)
        {
	    my %loop_row;
	    $loop_row{USER_MYLANG}    = $self->get_lang_name($mgr, $lang->[0]);
	    $loop_row{USER_MYLANGLVL}
	        = $mgr->{Func}->get_text($mgr, 1080 + ($lang->[1]));
	    push(@loop, \%loop_row);
	}
	$mgr->{TmplData}{USER_LOOP_MYLANGS} = \@loop;
    }

    #--- fill description part -----------------------------------------------#
    if ($desc)
    {
	$mgr->{TmplData}{USER_IF_FIRST_DESC} = 0;

	# language selection
	$self->fill_lang_select($mgr, $desclangs, undef, $desc_langid);
	$mgr->{TmplData}{PAGE_LANG_001076} = $mgr->{Func}->get_text($mgr, 1076);
	# description
	$mgr->{TmplData}{USER_DESC} = $desc;
    }
    else
    {
	$mgr->{TmplData}{USER_IF_FIRST_DESC} = 1;
    }

    #--- links to text module ------------------------------------------------#
    $mgr->{TmplData}{PAGE_LANG_001070} = $mgr->{Func}->get_text($mgr, 1070);
    $mgr->{TmplData}{USER_LINK_TEXT}   = $mgr->my_url(ACTION => "text") 
                                         . "&method=text";
    $mgr->{TmplData}{USER_LINK_TRANS}  = $mgr->my_url(ACTION => "text") 
                                         . "&method=trans";

    #--- mode-dependent settings ----------------------------------------------#
    if (defined($mode) and $mode eq 'other')
    {
	$mgr->{TmplData}{USER_IF_ME} = 0;
	$mgr->{TmplData}{PAGE_METHOD} = 'otherspage';
	$mgr->{TmplData}{USER_USERID} = $user_id;

	# language header
	$mgr->{TmplData}{PAGE_LANG_001059} = $mgr->{Func}->get_text($mgr, 1060);
	# description 
	$mgr->{TmplData}{PAGE_LANG_001062} = $mgr->{Func}->get_text($mgr, 1063);
	if (not $desc)
        {
	    $mgr->{TmplData}{PAGE_LANG_001078} = $mgr->{Func}->get_text($mgr, 1078);
        }	    
	# text links
	$mgr->{TmplData}{PAGE_LANG_001071} = $mgr->{Func}->get_text($mgr, 1072);
	$mgr->{TmplData}{PAGE_LANG_001073} = $mgr->{Func}->get_text($mgr, 1074);
    }
    else
    {
	$mgr->{TmplData}{USER_IF_ME} = 1;
	$mgr->{TmplData}{PAGE_METHOD} = 'mypage_upd';

	# user info part
	$mgr->{TmplData}{PAGE_LANG_001055} = $mgr->{Func}->get_text($mgr, 1055);
	# language part
	$mgr->{TmplData}{PAGE_LANG_001059} = $mgr->{Func}->get_text($mgr, 1059);
	$mgr->{TmplData}{PAGE_LANG_001061} = $mgr->{Func}->get_text($mgr, 1061);
	# description
	$mgr->{TmplData}{PAGE_LANG_001062} = $mgr->{Func}->get_text($mgr, 1062);
	if ($desc)
        {
	    # edit button
	    $mgr->{TmplData}{PAGE_LANG_001064} = $mgr->{Func}->get_text($mgr, 1064);
	    $mgr->{TmplData}{PAGE_LANG_001065} = $mgr->{Func}->get_text($mgr, 1065);
	    # new button
	    $mgr->{TmplData}{PAGE_LANG_001066} = $mgr->{Func}->get_text($mgr, 1066);
	    $mgr->{TmplData}{PAGE_LANG_001067} = $mgr->{Func}->get_text($mgr, 1067);
	}
	else
        {
	    $mgr->{TmplData}{PAGE_LANG_001068} = $mgr->{Func}->get_text($mgr, 1068);
	    $mgr->{TmplData}{PAGE_LANG_001069} = $mgr->{Func}->get_text($mgr, 1069);
	}
	# text links
	$mgr->{TmplData}{PAGE_LANG_001071} = $mgr->{Func}->get_text($mgr, 1071);
	$mgr->{TmplData}{PAGE_LANG_001073} = $mgr->{Func}->get_text($mgr, 1073);
    }	
}    


#
# fill update-syslang-template
# Params: 1. Manager ref
# No Return Value
#
sub show_upd_syslang
{
    my ($self, $mgr) = @_;
    my $username = $mgr->{Session}->get("UserName");
    my @syslangs = $mgr->{Func}->get_langs($mgr, 'system');
    
    # main template vars
    $mgr->{Template} = $mgr->{TmplFiles}->{User_UpdSyslang};
    $mgr->{Action} = "user";
    $mgr->{TmplData}{PAGE_TITLE}
        = $mgr->{Func}->get_text($mgr, 1110) . " " . $username;
    $mgr->{TmplData}{PAGE_METHOD} = 'upd_syslang';
    
    # fill system language select box
    $self->fill_lang_select($mgr, \@syslangs);
    
    # fill dictionary template vars
    $mgr->{TmplData}{USER_USERNAME}    = $username;
    $mgr->{TmplData}{PAGE_LANG_001110} = $mgr->{Func}->get_text($mgr, 1110);
    $mgr->{TmplData}{PAGE_LANG_001111} = $mgr->{Func}->get_text($mgr, 1111);
    $mgr->{TmplData}{PAGE_LANG_001112} = $mgr->{Func}->get_text($mgr, 1112);
}


#
# fill update-password-template
# Params: 1. Manager ref
#         2. error dict id (optional)
# No Return Value
#
sub show_upd_passwd
{
    my ($self, $mgr, $error) = @_;
    my $username = $mgr->{Session}->get("UserName");

    # main template vars
    $mgr->{Template} = $mgr->{TmplFiles}->{User_UpdPasswd};
    $mgr->{Action} = "user";
    $mgr->{TmplData}{PAGE_TITLE}
        = $mgr->{Func}->get_text($mgr, 1125) . " " . $username;
    $mgr->{TmplData}{PAGE_METHOD} = 'upd_passwd';
       
    # handle error
    if (defined($error))
    {
	$mgr->{TmplData}{USER_IF_PASSWD_ERR} = 1;
	$mgr->{TmplData}{USER_ERROR_PASSWD} 
	    = $mgr->{Func}->get_text($mgr, $error);
	$mgr->{TmplData}{PAGE_LANG_001134} = $mgr->{Func}->get_text($mgr, 1134);
    }
    else
    {
	$mgr->{TmplData}{USER_IF_PASSWD_ERR} = 0;
    }
	
    # fill dictionary template vars
    $mgr->{TmplData}{USER_USERNAME}    = $username;
    $mgr->{TmplData}{PAGE_LANG_001125} = $mgr->{Func}->get_text($mgr, 1125);
    $mgr->{TmplData}{PAGE_LANG_001126} = $mgr->{Func}->get_text($mgr, 1126);
    $mgr->{TmplData}{PAGE_LANG_001127} = $mgr->{Func}->get_text($mgr, 1127);
    $mgr->{TmplData}{PAGE_LANG_001128} = $mgr->{Func}->get_text($mgr, 1128);
    $mgr->{TmplData}{PAGE_LANG_001129} = $mgr->{Func}->get_text($mgr, 1129);
    $mgr->{TmplData}{PAGE_LANG_001130} = $mgr->{Func}->get_text($mgr, 1130);
    $mgr->{TmplData}{PAGE_LANG_001131} = $mgr->{Func}->get_text($mgr, 1131);
}


#
# fill password-ok-page
# Params: 1. Manager ref
# No Return Value
#
sub show_passwd_ok
{
    my ($self, $mgr) = @_;
    my $username = $mgr->{Session}->get("UserName");

    # main template vars
    $mgr->{Template} = $mgr->{TmplFiles}->{User_PasswdOK};
    $mgr->{Action} = "user";
    $mgr->{TmplData}{PAGE_TITLE}
        = $mgr->{Func}->get_text($mgr, 1139) . " " . $username;
    $mgr->{TmplData}{PAGE_METHOD} = 'mypage';
       
    # fill dictionary template vars
    $mgr->{TmplData}{USER_USERNAME}    = $username;
    $mgr->{TmplData}{PAGE_LANG_001139} = $mgr->{Func}->get_text($mgr, 1139);
    $mgr->{TmplData}{PAGE_LANG_001140} = $mgr->{Func}->get_text($mgr, 1140);
    $mgr->{TmplData}{PAGE_LANG_001141} = $mgr->{Func}->get_text($mgr, 1141);
}


#
# fill update-languages-template
# Params: 1. Manager ref
# No Return Value
#
sub show_upd_langs
{
    my ($self, $mgr) = @_;

    #--- get data -------------------------------------------------------------#
    my $user_id  = $mgr->{Session}->get("UserId");
    my $username = $mgr->{Session}->get("UserName");

    # get user's languages (ids) and levels (0-4) from db in a 2-d-array
    my $mylangs  = $self->get_mylangs_and_levels($mgr, $user_id);
    my $numlangs = @$mylangs;
    # save number of languages in session
    $mgr->{Session}->set(User_NumLangs => $numlangs);
    
    # get all languages
    my @langs = $mgr->{Func}->get_langs($mgr);
    my $lang;

    #--- user's languages part ------------------------------------------------#
    # main template vars
    $mgr->{Template} = $mgr->{TmplFiles}->{User_UpdLangs};
    $mgr->{Action} = "user";
    $mgr->{TmplData}{PAGE_TITLE}
        = $mgr->{Func}->get_text($mgr, 1110) . " " . $username;
    $mgr->{TmplData}{PAGE_METHOD} = 'upd_langs';
  
    # fill dictionary template vars
    $mgr->{TmplData}{USER_USERNAME}    = $username;
    $mgr->{TmplData}{PAGE_LANG_001115} = $mgr->{Func}->get_text($mgr, 1115);
    $mgr->{TmplData}{PAGE_LANG_001116} = $mgr->{Func}->get_text($mgr, 1116);
    $mgr->{TmplData}{PAGE_LANG_001117} = $mgr->{Func}->get_text($mgr, 1117);
    $mgr->{TmplData}{PAGE_LANG_001118} = $mgr->{Func}->get_text($mgr, 1118);

    # display all user's langs and levels plus change buttons
    $self->fill_langlvl_loop($mgr, $mylangs);

    #--- new language part ----------------------------------------------------#
    $mgr->{TmplData}{PAGE_LANG_001120} = $mgr->{Func}->get_text($mgr, 1120);
    $mgr->{TmplData}{PAGE_LANG_001121} = $mgr->{Func}->get_text($mgr, 1121);
    $mgr->{TmplData}{PAGE_LANG_001122} = $mgr->{Func}->get_text($mgr, 1122);

    # language levels in select box
    $mgr->{TmplData}{USER_OPT_LANGLVL_0} = $mgr->{Func}->get_text($mgr, 1080);
    $mgr->{TmplData}{USER_OPT_LANGLVL_1} = $mgr->{Func}->get_text($mgr, 1081);
    $mgr->{TmplData}{USER_OPT_LANGLVL_2} = $mgr->{Func}->get_text($mgr, 1082);
    $mgr->{TmplData}{USER_OPT_LANGLVL_3} = $mgr->{Func}->get_text($mgr, 1083);
    $mgr->{TmplData}{USER_OPT_LANGLVL_4} = $mgr->{Func}->get_text($mgr, 1084);

    # the language select box... fills in all langs except user's langs
    $self->fill_lang_select($mgr, \@langs, $mylangs);
}


#
# fill description-edit-template
# Params: 1. Manager ref
#         2. error dict id (optional)
# No Return Value
#
sub show_upd_descedit
{
    my ($self, $mgr, $error) = @_;

    #--- get data ------------------------------------------------------------#
    my $user_id  = $mgr->{Session}->get("UserId");
    my $username = $mgr->{Session}->get("UserName");

    # get language id of description from session
    my $desc_langid = $mgr->{Session}->get('UserDescLangId');

    # get languages of all descriptions by this user
    my $desclangs = $self->get_desclangs($mgr, $user_id);

    # get user's description (in desired language)
    my $desc;
    my $desc_langid_2;
    ($desc, $desc_langid_2)
        = $self->get_desc($mgr, $user_id, $desc_langid, $desclangs);

    # if desired desc does not occured, something got fucked up
    if ($desc_langid != $desc_langid_2)
    {
	warn sprintf("[Error:] attempt to retrieve nonexisting description " .
		     "in show_upd_descedit()");
    }

    #--- fill template  -------------------------------------------------------#

    # main template vars
    $mgr->{Template} = $mgr->{TmplFiles}->{User_UpdDescEdit};
    $mgr->{Action} = "user";
    $mgr->{TmplData}{PAGE_TITLE}
        = $mgr->{Func}->get_text($mgr, 1125) . " " . $username;
    $mgr->{TmplData}{PAGE_METHOD} = 'upd_descedit';

    # error?
    if (defined($error))
    {
	$mgr->{TmplData}{USER_IF_DESC_ERR} = 1;
	$mgr->{TmplData}{PAGE_LANG_001152} = $mgr->{Func}->get_text($mgr, 1152);
	$mgr->{TmplData}{USER_ERROR_DESC} 
	    = $mgr->{Func}->get_text($mgr, $error);
    }
    else
    {
	$mgr->{TmplData}{USER_IF_DESC_ERR} = 0;
    }	
	
    # language select box
    $self->fill_lang_select($mgr, $desclangs, undef, $desc_langid);
    # description
    $mgr->{TmplData}{USER_DESC} = $desc;

    # fill dictionary template vars
    $mgr->{TmplData}{USER_USERNAME}    = $username;
    $mgr->{TmplData}{PAGE_LANG_001144} = $mgr->{Func}->get_text($mgr, 1144);
    $mgr->{TmplData}{PAGE_LANG_001145} = $mgr->{Func}->get_text($mgr, 1145);
    $mgr->{TmplData}{PAGE_LANG_001146} = $mgr->{Func}->get_text($mgr, 1146);
    $mgr->{TmplData}{PAGE_LANG_001147} = $mgr->{Func}->get_text($mgr, 1147);
    $mgr->{TmplData}{PAGE_LANG_001148} = $mgr->{Func}->get_text($mgr, 1148);
    $mgr->{TmplData}{PAGE_LANG_001149} = $mgr->{Func}->get_text($mgr, 1149);
}


#
# fill description-edit-template
# Params: 1. Manager ref
#         2. error dict id (optional)
# No Return Value
#
sub show_upd_descnew
{
    my ($self, $mgr, $error) = @_;

    #--- get data -------------------------------------------------------------#
    my $user_id  = $mgr->{Session}->get("UserId");
    my $username = $mgr->{Session}->get("UserName");

    # get languages of all descriptions by this user
    my $desclangs = $self->get_desclangs($mgr, $user_id);

    my @langs = $mgr->{Func}->get_langs($mgr);

    #--- fill template  -------------------------------------------------------#
    # main template vars
    $mgr->{Template} = $mgr->{TmplFiles}->{User_UpdDescNew};
    $mgr->{Action} = "user";
    $mgr->{TmplData}{PAGE_TITLE}
        = $mgr->{Func}->get_text($mgr, 1156) . " " . $username;
    $mgr->{TmplData}{PAGE_METHOD} = 'upd_descnew';

    # error?
    if (defined($error))
    {
	$mgr->{TmplData}{USER_IF_DESC_ERR} = 1;
	$mgr->{TmplData}{PAGE_LANG_001152} = $mgr->{Func}->get_text($mgr, 1152);
	$mgr->{TmplData}{USER_ERROR_DESC} 
	    = $mgr->{Func}->get_text($mgr, $error);
    }
    else
    {
	$mgr->{TmplData}{USER_IF_DESC_ERR} = 0;
    }	
	
    # language selection: all except the ones that have been entered before
    $self->fill_lang_select($mgr, \@langs, $desclangs);

    # fill dictionary template vars
    $mgr->{TmplData}{USER_USERNAME}    = $username;
    $mgr->{TmplData}{PAGE_LANG_001156} = $mgr->{Func}->get_text($mgr, 1156);
    $mgr->{TmplData}{PAGE_LANG_001157} = $mgr->{Func}->get_text($mgr, 1157);
    $mgr->{TmplData}{PAGE_LANG_001158} = $mgr->{Func}->get_text($mgr, 1158);
    $mgr->{TmplData}{PAGE_LANG_001159} = $mgr->{Func}->get_text($mgr, 1159);
    $mgr->{TmplData}{PAGE_LANG_001160} = $mgr->{Func}->get_text($mgr, 1160);
    $mgr->{TmplData}{PAGE_LANG_001161} = $mgr->{Func}->get_text($mgr, 1161);
}


#
# fill admin user search page
# Params: 1. Manager ref
#         2. username (optional)
#         3. error dict id (optional)
# No Return Value
#
sub show_adm_search
{
    my ($self, $mgr, $username, $error) = @_;

    # main template vars
    $mgr->{Template} = $mgr->{TmplFiles}->{User_AdmSearch};
    $mgr->{Action}                = "user";
    $mgr->{TmplData}{PAGE_METHOD} = 'adm_search';
    $mgr->{TmplData}{PAGE_TITLE}  = $mgr->{Func}->get_text($mgr, 1164);

    # error?
    if (defined($error))
    {
	$mgr->{TmplData}{USER_IF_ADMIN_ERR} = 1;
	$mgr->{TmplData}{PAGE_LANG_001169} = $mgr->{Func}->get_text($mgr, 1169);
	$mgr->{TmplData}{USER_ERROR_ADMIN} 
	    = $mgr->{Func}->get_text($mgr, $error);
    }
    else
    {
	$mgr->{TmplData}{USER_IF_ADMIN_ERR} = 0;
    }	

    # fill dictionary template vars
    $mgr->{TmplData}{USER_USERNAME}    = $username if ($username);
    $mgr->{TmplData}{PAGE_LANG_001164} = $mgr->{Func}->get_text($mgr, 1164);
    $mgr->{TmplData}{PAGE_LANG_001165} = $mgr->{Func}->get_text($mgr, 1165);
    $mgr->{TmplData}{PAGE_LANG_001166} = $mgr->{Func}->get_text($mgr, 1166);
}


#
# fill user-admin page
# Params: 1. Manager ref
# No Return Value
#
sub show_admin_page
{
    my ($self, $mgr, $user_id) = @_;

    # main template vars
    $mgr->{Template}              = $mgr->{TmplFiles}->{User_Admin};
    $mgr->{Action}                = "user";
    $mgr->{TmplData}{PAGE_METHOD} = 'admin';
    $mgr->{TmplData}{PAGE_TITLE}  = $mgr->{Func}->get_text($mgr, 1174);

    my ($username, $firstname, $lastname, $email, $syslang_id, $lasttime, 
	$regtime, $level, $status) = $self->get_user_info($mgr, $user_id);

    # fill dictionary template vars
    $mgr->{TmplData}{USER_USERNAME} = $username;
    $mgr->{TmplData}{USER_LEVEL}  
        = $mgr->{Func}->get_text($mgr, 1088 + $level);
    $mgr->{TmplData}{USER_STATUS} 
        = $mgr->{Func}->get_text($mgr, 1187 + $status);
    $mgr->{TmplData}{PAGE_LANG_001174} = $mgr->{Func}->get_text($mgr, 1174);
    $mgr->{TmplData}{PAGE_LANG_001175} = $mgr->{Func}->get_text($mgr, 1175);
    $mgr->{TmplData}{PAGE_LANG_001176} = $mgr->{Func}->get_text($mgr, 1176);
    $mgr->{TmplData}{PAGE_LANG_001177} = $mgr->{Func}->get_text($mgr, 1177);
    $mgr->{TmplData}{PAGE_LANG_001178} = $mgr->{Func}->get_text($mgr, 1178);
    $mgr->{TmplData}{PAGE_LANG_001179} = $mgr->{Func}->get_text($mgr, 1179);
    $mgr->{TmplData}{PAGE_LANG_001180} = $mgr->{Func}->get_text($mgr, 1180);
    $mgr->{TmplData}{PAGE_LANG_001181} = $mgr->{Func}->get_text($mgr, 1181);
    $mgr->{TmplData}{PAGE_LANG_001182} = $mgr->{Func}->get_text($mgr, 1182);
    $mgr->{TmplData}{PAGE_LANG_001183} = $mgr->{Func}->get_text($mgr, 1183);
    $mgr->{TmplData}{PAGE_LANG_001184} = $mgr->{Func}->get_text($mgr, 1184);
    # level select box
    $mgr->{TmplData}{PAGE_LANG_001088} = $mgr->{Func}->get_text($mgr, 1088);
    $mgr->{TmplData}{PAGE_LANG_001089} = $mgr->{Func}->get_text($mgr, 1089);
    $mgr->{TmplData}{PAGE_LANG_001090} = $mgr->{Func}->get_text($mgr, 1090);
}

### PAGE DISPLAY AUXILARY FUNCTIONS ############################################

#
# fill language-and-level loop on language update page
# language ids are saved in session!!
# Params: 1. Manager ref.
#         2. user's languages as 2-D-array-ref
# No Return Value
#
sub fill_langlvl_loop
{
    my ($self, $mgr, $mylangs) = @_;
    my $lang;
    my @loop;

    my $i = 0;
    foreach $lang (@$mylangs)
    {
	my %loop_row;

	# the language name
	$loop_row{USER_MYLANG}      = $self->get_lang_name($mgr, $lang->[0]);
	# the select box name
	$loop_row{USER_SEL_LANGLVL} = "u_sel_langlvl_$i";

	# now for the lang levels
	$loop_row{USER_OPT_LANGLVL_0} = $mgr->{Func}->get_text($mgr, 1080);
	$loop_row{USER_OPT_LANGLVL_1} = $mgr->{Func}->get_text($mgr, 1081);
	$loop_row{USER_OPT_LANGLVL_2} = $mgr->{Func}->get_text($mgr, 1082);
	$loop_row{USER_OPT_LANGLVL_3} = $mgr->{Func}->get_text($mgr, 1083);
	$loop_row{USER_OPT_LANGLVL_4} = $mgr->{Func}->get_text($mgr, 1084);
	# 6th level: user can delete a language
	$loop_row{USER_OPT_LANGLVL_5} = $mgr->{Func}->get_text($mgr, 1085);
	# the default level

	my $default = $lang->[1];
	$loop_row{"USER_DEF_LANGLVL_$default"} = 'selected';

	# the submit button
	$loop_row{USER_SUB_LANGLVL} = "u_sub_langlvl_$i";
	$loop_row{PAGE_LANG_001119} = $mgr->{Func}->get_text($mgr, 1119);

	# last not least save the language index in session 
	#   (for use in method handler)
	$mgr->{Session}->set("User_LangId_$i" => $lang->[0]);

	# push row onto loop
	push(@loop, \%loop_row);
	$i++;
    }

    $mgr->{TmplData}{USER_LOOP_LANGLVL} = \@loop;
}


#
# fill languages for new language selection on language update page
# Params: 1. Manager ref.
#         2. ref to language names-and-ids, as returned from Func->get_langs
#         3. user's languages as 2-D-array-ref (which are excluded in loop)
#            (optional)
#         4. default selectd language (optional)
# No Return Value
#
sub fill_lang_select
{
    my ($self, $mgr, $langs, $mylangs, $default) = @_;
    my $lang;
    my @loop;

    foreach $lang (@$langs)
    {
	# see if this language is to be excluded
	if (defined($mylangs))
        {
	    my $noshow = 0;
	    my $mylang;
	    foreach $mylang (@$mylangs)
            {
		if ($mylang->[0] == $lang->[0])
	        {
		    $noshow = 1;
		    last;
		}
	    }
	    # go to next language if this one is not to be displayed
	    if ($noshow == 1) { next; }
	}

	my %loop_row;

	# push language name onto loop
	$loop_row{USER_OPTVAL_LANG} = $lang->[0];
	$loop_row{USER_OPT_LANG}    = $lang->[1];
	if (defined($default) and $default == $lang->[0])
        {
	    $loop_row{USER_DEF_LANG} = 'selected';
	}

	push(@loop, \%loop_row);
    }

    $mgr->{TmplData}{USER_LOOP_LANG} = \@loop;
}

### UPDATE DATABASE FUNCTIONS ##################################################

#
# adds a new user to database
# Params: 1. Manager ref
#         2. user name
#         3. first name
#         4. last name
#         5. email
#         6. system lang. id
# No Return value
#
sub add_user
{
    my ($self, $mgr, $username, $firstname, $lastname, $email, 
	$syslang_id) = @_;
    
    # check precondition: is all data correct?
    # if not simply do not add user to database!
    if ($self->check_reg($mgr, $username, $firstname, $lastname, $email,
			 $syslang_id) != 0)
    {
	return;
    }

    my $table = $mgr->{Tables}->{USER};
    my $dbh   = $mgr->connect(); 
    my $sth;

    # generate password and send it thru email
    my $passwd = $self->generate_passwd($mgr);
    $self->send_passwd($mgr, $username, $firstname, $lastname, $email, 
		       $syslang_id, $passwd);

    $dbh->do("LOCK TABLES $table WRITE");
    $sth = $dbh->prepare(<<SQL);

INSERT INTO $table (username, firstname, lastname, password, email, points, 
status, level, system_lang, reg_time)
VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)

SQL

    unless ($sth->execute($username, $firstname, $lastname, $passwd, $email,
			  "1000", "1", "0", $syslang_id, time())) 
    {
	warn sprintf("[Error:] Trouble adding user to %s. " .
		     "Reason: [%s].", $table, $dbh->errstr());
	$dbh->do("UNLOCK TABLES");
	$mgr->fatal_error("Database error.");
    }

    $dbh->do("UNLOCK TABLES");   
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

    my $dbh   = $mgr->connect();
    my $table = $mgr->{Tables}->{USER_LANG};
    my $result_row;   # a row (ref) resulting from a query

    $dbh->do("LOCK TABLES $table READ");
    my $sth   = $dbh->prepare(<<SQL);

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
# adds a language of a new user to database
# Params: 1. Manager ref
#         2. user_id
#         3. lang_id
#         4. description
# Returns $error_lang_id
#
sub add_new_desc
{
    my ($self, $mgr, $user_id, $lang_id, $description) = @_;

    return 0;
}


#
# changes a user's system language (does not verify whether lang_id really is a 
#                                   syslang!)
# Params: 1. Manager ref
#         2. lang_id
# No Return value
#
sub upd_syslang
{
    my ($self, $mgr, $user_id, $lang_id) = @_;

    my $dbh = $mgr->connect();
    my $table = $mgr->{Tables}->{USER};

    $dbh->do("LOCK TABLES $table WRITE");
    my $sth = $dbh->prepare(<<SQL);

UPDATE $table
SET system_lang = ?
WHERE user_id = ?

SQL

    unless ($sth->execute($lang_id, $user_id))
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
# changes a user's password
# Params: 1. Manager ref
#         2. user id
#         3. password
# No Return value
#
sub upd_passwd
{
    my ($self, $mgr, $user_id, $passwd) = @_;

    my $dbh = $mgr->connect();
    my $table = $mgr->{Tables}->{USER};

    $dbh->do("LOCK TABLES $table WRITE");
    my $sth = $dbh->prepare(<<SQL);

UPDATE $table
SET password = ?
WHERE user_id = ?

SQL

    unless ($sth->execute($passwd, $user_id))
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
# updates a language level of a user (or delete the language entirely)
# Params: 1. Manager ref  
#         2. user id
#         3. language index  
#         4. level (0-4 or 5 for deleting the language)
# No Return value
#
sub upd_langlvl
{
    my ($self, $mgr, $user_id, $lang_id, $level) = @_;

    my $dbh = $mgr->connect();
    my $sth;
    my $sql_return;   # return value from sql statement
    my $table = $mgr->{Tables}->{USER_LANG};

    $dbh->do("LOCK TABLES $table WRITE");

    # a level between 0 and 4 is a 'normal' level
    if ($level <= 4) 
    {
	$sth = $dbh->prepare(<<SQL);

UPDATE $table
SET level = ?
WHERE user_id = ? AND lang_id = ?

SQL

        $sql_return = $sth->execute(1+$level, $user_id, $lang_id);
    }

    # level = 5 means 'delete this user language'
    elsif ($level == 5)
    {
	$sth = $dbh->prepare(<<SQL);

DELETE FROM $table
WHERE user_id = ? AND lang_id = ?

SQL
        $sql_return = $sth->execute($user_id, $lang_id);
    }

    # level > 5: something got messed up (issue a warning)
    else
    {
	warn sprintf("[Error:] lang-level parameter should be between " .
		     " 0 and 5 in upd_langlvl()");
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
# updates or adds or deletes a description
# Params: 1. Manager ref  
#         2. User ID
#         3. language index  
#         4. description
# No Return value
#
sub upd_desc
{
    my ($self, $mgr, $user_id, $lang_id, $desc) = @_;

    my $dbh   = $mgr->connect();
    my $table = $mgr->{Tables}->{USER_DESC};
    my $result_row;   # a row (ref) resulting from a query

    # first, see if a description in this language already exists
    $dbh->do("LOCK TABLES $table READ");
    my $sth   = $dbh->prepare(<<SQL);

SELECT lang_id
FROM $table
WHERE user_id = ? AND lang_id = ?

SQL

    unless ($sth->execute($user_id, $lang_id)) 
    {
	warn sprintf("[Error:] Trouble selecting from %s. " .
		     "Reason: [%s].", $table, $dbh->errstr());
	$dbh->do("UNLOCK TABLES");
	$mgr->fatal_error("Database error.");
    }

    $dbh->do("UNLOCK TABLES");

    # if description exists, update it - or delete it, if $desc is empty
    if ($sth->fetchrow_array())
    {
	$sth->finish();
	$dbh->do("LOCK TABLES $table WRITE");

	# if description is empty, delete it
	if (length($desc) == 0)
        {
	    $sth   = $dbh->prepare(<<SQL);

DELETE FROM $table
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
	}
	# if it's not empty, update the desc.
	else
        {
	    $sth   = $dbh->prepare(<<SQL);

UPDATE $table
SET desc_text = ?
WHERE user_id = ? AND lang_id = ?

SQL
            unless ($sth->execute($desc, $user_id, $lang_id)) 
            {
		warn sprintf("[Error:] Trouble updating %s. " .
		             "Reason: [%s].", $table, $dbh->errstr());
		$dbh->do("UNLOCK TABLES");
		$mgr->fatal_error("Database error.");
	    }
	    $dbh->do("UNLOCK TABLES");
        }

	# ok, we're done
	return;
    }

    # else add new description
    $sth->finish();
    $dbh->do("LOCK TABLES $table WRITE");
    $sth = $dbh->prepare(<<SQL);

INSERT INTO $table (user_id, lang_id, desc_text)
VALUES (?, ?, ?)

SQL

    unless ($sth->execute($user_id, $lang_id, $desc)) 
    {
	warn sprintf("[Error:] Trouble updating %s. " .
		     "Reason: [%s].", $table, $dbh->errstr());
	$dbh->do("UNLOCK TABLES");
	$mgr->fatal_error("Database error.");
    }

    $dbh->do("UNLOCK TABLES");    
}

### GET DATA FROM DATABASE FUNCTIONS ###########################################

#
# selects user info from lingua_user
# Params: 1. Manager ref
#         2. user id
# Returns a list: ($firstname, $lastname, $email, $syslang_id, $last_login, 
#                  $reg_time, $status)
#
sub get_user_info
{
    my ($self, $mgr, $user_id) = @_;
    my $dbh   = $mgr->connect();
    my $table = $mgr->{Tables}->{USER};

    $dbh->do("LOCK TABLES $table READ");
    my $sth = $dbh->prepare(<<SQL);

SELECT username, firstname, lastname, email, system_lang, last_login, reg_time, 
       level, status
FROM $table
WHERE user_id = ? 

SQL

    unless ($sth->execute($user_id)) 
    {
	warn sprintf("[Error:] Trouble selecting from %s. " .
		     "Reason: [%s].", $table, $dbh->errstr());
	$dbh->do("UNLOCK TABLES");
	$mgr->fatal_error("Database error.");
    }

    $dbh->do("UNLOCK TABLES");

    my @result = $sth->fetchrow_array();
    $sth->finish();
    return @result;
}


#
# selects all languages spoken by a user and their levels
# Params: 1. Manager ref
#         2. user id
# Returns a ref to a 2-D-array: 
#     $return->[$i]->[0] = lang_id
#     $return->[$i]->[1] = level (0 = highest, 4 = lowest)
#
sub get_mylangs_and_levels
{
    my ($self, $mgr, $user_id) = @_;
    my $dbh = $mgr->connect();
    my $table = $mgr->{Tables}->{USER_LANG};

    $dbh->do("LOCK TABLES $table READ");
    my $sth = $dbh->prepare(<<SQL);

SELECT lang_id, level 
FROM $table
WHERE user_id = ? 

SQL

    unless ($sth->execute($user_id)) 
    {
	warn sprintf("[Error:] Trouble selecting from %s. " .
		     "Reason: [%s].", $table, $dbh->errstr());
	$dbh->do("UNLOCK TABLES");
	$mgr->fatal_error("Database error.");
    }

    $dbh->do("UNLOCK TABLES");

    my $result = $sth->fetchall_arrayref();
    $sth->finish();
    return $result;
}


#
# selects languages of all descriptions submitted by a user 
# Params: 1. Manager ref
#         2. user id
# Returns a ref to a 2-d-array of language ids and lang names
#
sub get_desclangs
{
    my ($self, $mgr, $user_id) = @_;
    my $dbh = $mgr->connect();
    my $table = $mgr->{Tables}->{USER_DESC};

    $dbh->do("LOCK TABLES $table READ");
    my $sth = $dbh->prepare(<<SQL);

SELECT lang_id, user_id
FROM $table
WHERE user_id = ? 

SQL

    unless ($sth->execute($user_id)) 
    {
	warn sprintf("[Error:] Trouble selecting from %s. " .
		     "Reason: [%s].", $table, $dbh->errstr());
	$dbh->do("UNLOCK TABLES");
	$mgr->fatal_error("Database error.");
    }

    $dbh->do("UNLOCK TABLES");

    my $result = $sth->fetchall_arrayref();
    my $lang;
    foreach $lang (@$result)
    {
	$lang->[1] = $self->get_lang_name($mgr, $lang->[0]);
    }
    $sth->finish();
    return $result;
}


#
# retrieves the description in a language that fits best:
#   try the supplied desc_langid first, then current syslang, then default
# Params: 1. Manager ref
#         2. user id
#         3. desired description language id
#         4. ref to array of language ids of all descriptions of this user
# Returns a list: (the description, desc lang id)
#
sub get_desc
{
    my ($self, $mgr, $user_id, $desc_langid, $desclangs) = @_;
    my $lang_id1 = 0;   # first choice of description lang id
    my $lang_id2 = 0;   # second choice (in case first choice is 0)

    # search for first and second choice of desc lang id
    if (defined($desc_langid))
    {
	my $id;
	foreach $id (@$desclangs)
        {
	    if ($id->[0] == $desc_langid) 
	    {
		$lang_id1 = $id->[0];
		last;
	    }
	    if ($id->[0] == $mgr->{Language})
            {
		$lang_id2 = $id;
	    }
	}
    }

    # determine desc lang id (into $lang_id1)
    if ($lang_id1 == 0) 
    {
	$lang_id1 = $lang_id2;
    }
    if (defined($desclangs) and $lang_id1 == 0)
    { 
	$lang_id1 = $desclangs->[0]->[0];
    }

    # get desired desc
    my $dbh   = $mgr->connect();
    my $table = $mgr->{Tables}->{USER_DESC};

    $dbh->do("LOCK TABLES $table READ");
    my $sth = $dbh->prepare(<<SQL);

SELECT desc_text
FROM $table
WHERE user_id = ? AND lang_id = ? 

SQL

    unless ($sth->execute($user_id, $lang_id1)) 
    {
	warn sprintf("[Error:] Trouble selecting from %s. " .
		     "Reason: [%s].", $table, $dbh->errstr());
	$dbh->do("UNLOCK TABLES");
	$mgr->fatal_error("Database error.");
    }

    $dbh->do("UNLOCK TABLES");

    my $result = $sth->fetchrow_arrayref();
    $sth->finish();
    return ($result->[0], $lang_id1);
}


#
# Returns the name of a language in the current session's lang
# Params: 1. Manager ref  
#         2. language id 
# Return value: the language name (you've probably guessed that...)
#
sub get_lang_name 
{
    my ($self, $mgr, $lang_id) = @_;

    my $table = $mgr->{Tables}->{LANG};
    my $dbh   = $mgr->connect();

    $dbh->do("LOCK TABLES $table READ");
    my $sth        = $dbh->prepare(<<SQL);

SELECT lang_name_id
FROM $table
WHERE lang_id = ?

SQL

    unless ($sth->execute($lang_id)) 
    {
	warn sprintf("[Error:] Trouble selecting from [%s]. ".
		     "Reason: [%s].", $table, $dbh->errstr());
	$dbh->do("UNLOCK TABLES");
	$mgr->fatal_error("Database error.");
    }

    $dbh->do("UNLOCK TABLES");

    my $dict_id = $sth->fetchrow_arrayref()->[0];
    $sth->finish();

    return $mgr->{Func}->get_text($mgr, $dict_id);
}

### Check Input Functions ######################################################

#
# checks user input on registration form
# Params: 1. Manager ref.
#         2. username
#         3. firstname
#         4. lastname
#         5. email adress
#         6. system lang_id
# Returns error lang_id (0 upon success)
#
sub check_reg
{
    my ($self, $mgr, $username, $firstname, $lastname, $email, $syslang) = @_;

    my $table = $mgr->{Tables}->{USER};
    my $dbh   = $mgr->connect(); 
    my $sth;
    my @result_row;   

    # check if all forms are filled out
    if (not defined($username) or not defined($firstname) or
	not defined($lastname) or not defined($email) or
	$username eq '' or $firstname eq '' or $lastname eq '' or $email eq '')
    {
	return 1028;
    }
    # check if email address is correct
    if (not $self->check_email($mgr, $email))
    {
	return 1026;
    }
    # check if username is correct
    if (not $self->check_username($mgr, $username))
    {
	return 1027;
    }

    # check if username or email exists already
    $dbh->do("LOCK TABLES $table READ");
    $sth = $dbh->prepare(<<SQL);

SELECT LOWER(username), LOWER(email)
FROM $table
WHERE LOWER(username)=LOWER(?) OR LOWER(email)=LOWER(?)
SQL

    unless ($sth->execute($username, $email)) 
    {
	warn sprintf("[Error:] Trouble selecting user from %s. " .
		     "Reason: [%s].", $table, $dbh->errstr());
	$dbh->do("UNLOCK TABLES");
	$mgr->fatal_error("Database error.");
    }

    $dbh->do("UNLOCK TABLES");   
    
    @result_row = $sth->fetchrow_array();
    $sth->finish();

    if (@result_row)
    {
	if ($self->tolower($username) eq $self->tolower($result_row[0]))
        {
	    return 1024;
	}
	if ($self->tolower($email) eq $self->tolower($result_row[1]))
        {
	    return 1025;
	}

	# oops something got fucked up...
	warn sprintf("[Error:] Comparison error in check_reg1." );
	$mgr->fatal_error("User module error.");
	return 1024;
    }

    # all ok !
    return 0;
}


#
# checks if an email address is valid
# Params: 1. Manager ref
#         2. email address
# Returns 1 if email is valid, 0 otherwise
#
sub check_email
{
    my ($self, $mgr, $email) = @_;

    if ($email =~ /^\s*[A-Za-z\d]([\w\-\$\.]*[A-Za-z\d])?\@([A-Za-z0-9\-?!\.]+\.)+[A-Za-z]{2,}\s*$/) 
    {
	return 1;
    } 
    return 0;
}


#
# checks if a username is correct
# Params: 1. Manager ref
#         2. username
# Returns 1 if username is valid, 0 otherwise
#
sub check_username
{
    my ($self, $mgr, $username) = @_;

    if ($username =~ /^([a-zA-Z0-9]{3,10})$/ ) 
    {
	return 1;
    }
    return 0;
}


#
# checks password (and retyped password) is correct
# Params: 1. Manager ref
#         2. password 1
#         3. password 2
# Returns 0 if password is valid
#         else an error dictionary id
#
sub check_passwd
{
    my ($self, $mgr, $passwd1, $passwd2) = @_;

    if ($passwd1 ne $passwd2)
    {
	return 1135;
    }
    unless ($passwd1 =~ /^([a-zA-Z0-9]{5,10})$/ ) 
    {
	return 1136;
    }
    return 0;
}


#
# checks description (if it's shorter than 400 characters)
# Params: 1. Manager ref
#         2. description
# Returns 0 if description is correct
#         else an error dictionary id
#
sub check_desc
{
    my ($self, $mgr, $desc) = @_;

    if (length($desc) > 400)
    {
	return 1153;
    }
    return 0;
}


#
# checks if there is a user with this username
# Params: 1. Manager ref
#         2. username
# Returns a list: ($user_id, $error)
#         upon success, a user id and $error=0
#         no user id and an error dict id otherwise
#
sub check_user_search
{
    my ($self, $mgr, $username) = @_;

    # check if username is valid
    if (not $self->check_username($mgr, $username))
    {
	return (0, 1171);
    }

    # check if username exists
    my $table = $mgr->{Tables}->{USER};
    my $dbh   = $mgr->connect(); 

    $dbh->do("LOCK TABLES $table READ");
    my $sth = $dbh->prepare(<<SQL);

SELECT user_id
FROM $table
WHERE LOWER(username)=LOWER(?)
SQL

    unless ($sth->execute($username)) 
    {
	warn sprintf("[Error:] Trouble selecting user from %s. " .
		     "Reason: [%s].", $table, $dbh->errstr());
	$dbh->do("UNLOCK TABLES");
	$mgr->fatal_error("Database error.");
    }

    $dbh->do("UNLOCK TABLES");   
    
    # yippie there is a user with that username
    if (my $result = $sth->fetchrow_arrayref())
    {
	$sth->finish();
 	return ($result->[0], 0);
    }
    # arw... not found
    $sth->finish();
    return (0, 1170);
}

### Auxiliary Functions ########################################################

#
# good ol' c ... (used in check_reg)
#
sub tolower
{
    my ($self, $word) = @_;
    $word =~ tr/A-Z/a-z/ if defined($word);
    return $word;
}


#
# converts a unix time coordinate to a readable string
# Params: 1. utc
# Return Value: the time string
#
sub timestring
{
    my ($self, $time) = @_;
    my ($sec, $min, $hour, $mday, $mon, $year) = gmtime($time);

    if ($mday < 10)
    {
	$mday = "0" . $mday;
    }
    if ($mon < 10)
    {
	$mon = "0" . (1 + $mon);
    }
    if ($min < 10)
    {
	$min = "0" . $min;
    }
    
    $year = 1900 + $year;
    return "$mday.$mon.$year, $hour:$min";
}   


#
# generates an eight-letter-password
# Params: 1. Manager ref
# Returns the password
#
sub generate_passwd
{
    my ($self, $mgr) = @_;
    my $password = '';

    for (my $i = 0; $i < 8; $i++) 
    {
	my $j = rand(3);
	if ($j < 1) 
        {
	    $password .= chr(rand(10) + 48)
	} 
	elsif ($j < 2) 
        {
	    $password .= chr(rand(26) + 65)
	} 
	elsif ($j < 3) 
        {
	    $password .= chr(rand(26) + 97)
	}
    }
    return $password;
}


#
# sends an email with the password to a new user
# Params: 1. Manager ref
#         2. username
#         3. firstname
#         4. lastname
#         5. email adress
#         6. system lang_id
#         7. password
# No Return value
#
sub send_passwd
{
    my ($self, $mgr, $username, $firstname, $lastname, $email, $syslang_id, 
	$passwd) = @_;

    my $message = 
        $mgr->{Func}->get_text($mgr, 1093) . " $firstname $lastname \n\n" .
	$mgr->{Func}->get_text($mgr, 1094) . "\n" .
	$mgr->{Func}->get_text($mgr, 1095) . "\n\n    " .
	$mgr->{Func}->get_text($mgr, 1096) . ": $username \n    " .
	$mgr->{Func}->get_text($mgr, 1097) . ": $passwd \n\n" .
	$mgr->{Func}->get_text($mgr, 1098) . "\n\n" .
	$mgr->{Func}->get_text($mgr, 1099) . "\n";

    my %mail = 
    ( 
        To         => $email,
	From       => 'admin@smp.dark-sun.org',
        Subject    => $mgr->{Func}->get_text($mgr, 1100),
	Message    => $message,
        smtp       => 'admin@127.0.0.1',
        'X-Mailer' => "Lingua Webmailer",
        debug      => '1'
    );

    warn "$message";

#    unless (sendmail(%mail))
#    { 
#	warn sprintf("[Error:] Sendmail reports %s", $Mail::Sendmail::error);
#	$mgr->fatal_error("Sendmail error");
#    }

#    print "OK. Log says:\n", $Mail::Sendmail::log;
}

1;



