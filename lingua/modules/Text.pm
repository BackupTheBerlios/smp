package modules::Text;

use Class::Singleton;
use base 'Class::Singleton';
use vars qw($VERSION);
use strict;



$VERSION = sprintf "%d.%03d", q$Revision: 1.34 $ =~ /(\d+)\.(\d+)/;



#-----------------------------------------------------------------------------#
# CALL:   $self->parameter($mgr).                                             #
#                                                                             #
#         $mgr = manager object.                                              #
#                                                                             #
# AUTHOR: Sören Wurch (sowuinfo@cs.tu-berlin.de)                              #
#                                                                             #
# DESC:   Main function for the Text module.                                  #
#                                                                             #
# RETURN: none.                                                               #
#-----------------------------------------------------------------------------#
sub parameter {
  my ($self, $mgr) = @_;

  my $method = $mgr->{CGI}->param('method');

  if ($method eq "new") {
    $self->text_new($mgr);

  } elsif(defined $mgr->{CGI}->param('text_add')) {
    $self->text_add($mgr);

  } elsif (defined $mgr->{CGI}->param('show_text_upload')) {
    $self->show_text_upload($mgr);

  } elsif (defined $mgr->{CGI}->param('text_upload')) {
    $self->text_upload($mgr);

  } elsif ($method eq "upload_back") {
    $self->text_new($mgr, "upload_back");

  } elsif ($method eq "show_texts" || defined $mgr->{CGI}->param('show_texts')) {
    $self->show_texts($mgr);

 } elsif ($method eq "text_trans" || defined $mgr->{CGI}->param('text_trans')) {
    $self->text_trans($mgr);

 } elsif ($method eq "text_trans_upload") {
    $self->show_text_trans_upload($mgr);

 } elsif ($method eq "text_trans_insert_ok") {
    $self->text_trans_insert_ok($mgr);

 } elsif ($method eq "text_message_user") {
    $self->show_text_user_message($mgr);

 } elsif ($method eq "delete_trans_res") {
    $self->delete_trans_res($mgr);

 } elsif ($method eq "text_to_trans_download" || defined $mgr->{CGI}->param('text_to_trans_download')) {
    $self->text_to_trans_download($mgr);

 } elsif ($method eq "res_trans_upload") {
    $self->res_trans_upload($mgr);

 } elsif ($method eq "download_text") {
    $self->download_text($mgr);

 } elsif ($method eq 'delete_text' || defined $mgr->{CGI}->param('delete_text')) {    # by Hendrik Erler
    $self->delete_text($mgr);                                                         # by Hendrik Erler

 } elsif ($method eq 'delete_all_orig' || defined $mgr->{CGI}->param('delete_all_orig')) { # by Hendrik Erler
    $self->delete_all($mgr);                                                           # by Hendrik Erler

 } elsif ($method eq 'text_rating' || defined $mgr->{CGI}->param('text_rating')) {     # by Hendrik Erler
    $self->text_rating($mgr);                                                          # by Hendrik Erler

 } elsif ($method eq 'view_trans' || defined $mgr->{CGI}->param('view_trans')) {        # by Hendrik Erler
    $self->show_text_see($mgr);                                                       # by Hendrik Erler

 } elsif ($method eq 'dont_delete_orig' || defined $mgr->{CGI}->param('dont_delete_orig')) {        # by Hendrik Erler
    $self->show_text_see($mgr);                                                       # by Hendrik Erler

 } elsif ($method eq 'dont_delete_trans' || defined $mgr->{CGI}->param('dont_delete_trans')) {        # by Hendrik Erler
    $self->show_text_see($mgr);                                                       # by Hendrik Erler

 } elsif ($method eq 'text_show' || defined $mgr->{CGI}->param('text_show')) {        # by Hendrik Erler
    $self->show_text_see($mgr);                                                       # by Hendrik Erler

 } elsif ($method eq 'text' || defined $mgr->{CGI}->param('text')) {                   # by Hendrik Erler
    $self->texts_own($mgr);                                                            # by Hendrik Erler

 } elsif ($method eq 'trans' || defined $mgr->{CGI}->param('trans')) {                 # by Hendrik Erler
    $self->trans_own($mgr);                                                            # by Hendrik Erler

   } else {
	if (defined $mgr->{CGI}->param('change_lang_text_insert_ok')) {
		$self->text_insert_ok($mgr);
	}else{
		$self->text_new($mgr);
	}
  }
}



sub check_lang{
my $self = shift;
my $mgr  = shift;
my $lang = shift;
my $text_id = shift;
my $val = 0;

my @langs =  $self->get_text_langs($mgr, $text_id);

		foreach my $elem (@langs){
			if ($elem eq $lang){ return 1; }
		}
return $val;
}




sub Check_Code{
  my $self = shift;
  my $mgr  = shift;
  my $text = shift || undef;
  
my $meldung=0;
my @bytes;
my $lentgh;

my $index=0;
my $follower=0;
my $bstring;

	@bytes    = split //, $text;
	$lentgh   = @bytes;
	$follower=0;

	while (($index < $lentgh) && ($follower<3)) {

		$bstring = sprintf "%08b", ord($bytes[$index]);

		if ($bstring =~ /^0/) {$follower = 0; }
		elsif ($bstring =~ /^110/) {$follower = 1; }
		elsif ($bstring =~ /^1110/){$follower = 2; }
		else {$follower = 3;}
	
		if ($follower == 0){$index = $index +1;}
		elsif ($follower == 1){
			if ($index+1 < $lentgh){			
				$index=$index+1;			
				$bstring = sprintf "%08b", ord($bytes[$index]);

				if ($bstring =~ /^10/ ){ $index = $index +1;}
				else {$follower=3;}
			}else {$follower=3;}
		}
					
		elsif ($follower == 2){
			if ($index+2 < $lentgh){
				$index=$index+1;
				$bstring = sprintf "%08b", ord($bytes[$index]);

				if ($bstring =~ /^10/){
					$index=$index+1;
					$bstring = sprintf "%08b", ord($bytes[$index]);
					
					if ($bstring =~ /^10/){$index = $index +1;}
					else {$follower=3;}
				}else{ $follower=3;}
		    	}else {$follower=3;}
		}
		

	}

 return $follower;
}




#-----------------------------------------------------------------------------#
# CALL:   $self->text_new($mgr, $mode).                                       #
#                                                                             #
#         $mgr  = manager object.                                             #
#         $mode = mode (change, upload_back).                                 #
#                                                                             #
# AUTHOR: Sören Wurch (sowuinfo@cs.tu-berlin.de)                              #
#                                                                             #
# DESC:   Create a form for inserting a new text.                             #
#                                                                             #
# RETURN: none.                                                               #
#-----------------------------------------------------------------------------#
sub text_new {
  my $self = shift;
  my $mgr  = shift;
  my $mode = shift || '';

  my $cat_id          = $mgr->{CGI}->param('cat_id') || undef;

  my $text_lang       = $mgr->{CGI}->param('text_lang') || '1';
  my $text_lang_trans = $mgr->{CGI}->param('text_lang_trans') || '1';

  my $code;
  my $head = $mgr->unescape($mgr->{CGI}->param('text_header')) || '';
  my $desc = $mgr->unescape($mgr->{CGI}->param('text_desc'))|| '';
  my $text; 
  
  if (defined $mgr->{CGI}->param('change_lang')) {    
       $text = $mgr->unescape($mgr->{CGI}->param('text_text')) || undef;

    if (!($head eq '')){	$code 		= $self->Check_Code($mgr, $head);}
    if ((!($desc eq '')) and ($code<3)){$code 	= $self->Check_Code($mgr, $desc);}
    if ((defined $text) and ($code<3)){$code 	= $self->Check_Code($mgr, $text);}

    if ($code==3){ $mgr->{TmplData}{TEXT_ERROR} = $mgr->{Func}->get_text($mgr, 8000);}

    $mgr->{TmplData}{TEXT_HEADER} =  $mgr->escape($head);
    $mgr->{TmplData}{TEXT_DESC}   =  $mgr->escape($desc);
    $mgr->{TmplData}{TEXT_TEXT}   =  $mgr->escape($text);

    $cat_id = $mgr->{Session}->get("TextCatId");

  }elsif ($mode eq "WrongCode") {
    $cat_id    = $mgr->{Session}->get("TextCatId");

  # If mode eq "change", we fill the form again.
  }elsif ($mode eq "change") {

    $head = $mgr->unescape($mgr->{CGI}->param('text_header'));
    $desc = $mgr->unescape($mgr->{CGI}->param('text_desc'));
    $text = $mgr->unescape($mgr->{CGI}->param('text_text'));

    $mgr->{TmplData}{TEXT_HEADER} = $mgr->escape($head);
    $mgr->{TmplData}{TEXT_DESC}   = $mgr->escape($desc);
    $mgr->{TmplData}{TEXT_TEXT}   = $mgr->escape($text);

    $cat_id    = $mgr->{Session}->get("TextCatId");

  # If we came from the upload form, we fill the form again.
  }elsif ($mode eq "upload_back") {

    my $check_text = $mgr->{Session}->get("TextText");
    $head = $mgr->{Session}->get("TextHeader");
    $desc = $mgr->{Session}->get("TextDesc");

    if ((defined $check_text) and (defined $mgr->{CGI}->param('text_file'))){
	$code = $self->Check_Code($mgr, $check_text);}
    
    if ($code==3){ 
	$mgr->{TmplData}{TEXT_ERROR} = $mgr->{Func}->get_text($mgr, 8001);
    }else{

     	if (defined $head ){$code = $self->Check_Code($mgr, $head);}
	if ((defined $desc) and ($code<3)){$code = $self->Check_Code($mgr, $desc);}
	if ($code==3){ $mgr->{TmplData}{TEXT_ERROR} = $mgr->{Func}->get_text($mgr, 8000); }

        $mgr->{TmplData}{TEXT_TEXT}   =  $mgr->escape($check_text);

     }

    $text_lang_trans = $mgr->{Session}->get("TextLangTrans");
    $text_lang       = $mgr->{Session}->get("TextLang");
    $cat_id          = $mgr->{Session}->get("TextCatId");

    $mgr->{TmplData}{TEXT_HEADER} = $mgr->escape($head);
    $mgr->{TmplData}{TEXT_DESC}   = $mgr->escape($desc);
		
    $mgr->{Session}->del("TextText");
    $mgr->{Session}->del("TextHeader");
    $mgr->{Session}->del("TextDesc");

  } else {
    $mgr->{Session}->set("TextCatId", $cat_id);
  }

  my @cat = $mgr->{Func}->get_cat($mgr, $cat_id);

  $mgr->{TmplData}{TEXT_CAT_BACK}    = $mgr->my_url(ACTION => "home");
  $mgr->{TmplData}{PAGE_LANG_007001} = $mgr->{Func}->get_text($mgr, 7001);
  $mgr->{TmplData}{PAGE_LANG_007000} = $mgr->{Func}->get_text($mgr, 7000);
  $mgr->{TmplData}{TEXT_CAT_NAME}    = $cat[2];
  $mgr->{TmplData}{PAGE_LANG_007002} = $mgr->{Func}->get_text($mgr, 7002);
  $mgr->{TmplData}{PAGE_LANG_007003} = $mgr->{Func}->get_text($mgr, 7003);
  $mgr->{TmplData}{PAGE_LANG_007004} = $mgr->{Func}->get_text($mgr, 7004);
  $mgr->{TmplData}{PAGE_LANG_007005} = $mgr->{Func}->get_text($mgr, 7005);
  $mgr->{TmplData}{PAGE_LANG_007006} = $mgr->{Func}->get_text($mgr, 7006);
  $mgr->{TmplData}{PAGE_LANG_007012} = $mgr->{Func}->get_text($mgr, 7012);
  $mgr->{TmplData}{PAGE_LANG_007017} = $mgr->{Func}->get_text($mgr, 7017);

  my @langs      = $mgr->{Func}->get_langs($mgr);
  my $lang_count = 0;
  my (@lang_result, @lang_trans_result);

  # Get the source and destination language.
  foreach my $lang (@langs) {
    if ($lang->[0] == $text_lang) {
      $lang_result[$lang_count]{TEXT_LANG_IF} = 1;
    }

    if ($lang->[0] == $text_lang_trans) {
      $lang_trans_result[$lang_count]{TEXT_LANG_IF} = 1;
    }

    $lang_result[$lang_count]{TEXT_LANG_ID}         = $lang->[0];
    $lang_result[$lang_count]{TEXT_LANG_NAME}       = $lang->[1];

    $lang_trans_result[$lang_count]{TEXT_LANG_ID}   = $lang->[0];
    $lang_trans_result[$lang_count]{TEXT_LANG_NAME} = $lang->[1];

    $lang_count++;
  }

@lang_trans_result = sort {$a->{TEXT_LANG_NAME} cmp $b->{TEXT_LANG_NAME}} @lang_trans_result;
@lang_result = sort {$a->{TEXT_LANG_NAME} cmp $b->{TEXT_LANG_NAME}} @lang_result;

  $mgr->{TmplData}{LOOP_TEXT_LANG_TRANS} = \@lang_trans_result;
  $mgr->{TmplData}{LOOP_TEXT_LANG}       = \@lang_result;

$mgr->{TmplData}{PAGE_TITLE}  = $mgr->{Func}->get_text($mgr, 8003);
  $mgr->{Template}                       = $mgr->{TmplFiles}->{Text_New};
  
 
}

#-----------------------------------------------------------------------------#
# CALL:   $self->text_add($mgr).                                              #
#                                                                             #
#         $mgr = manager object.                                              #
#                                                                             #
# AUTHOR: Sören Wurch (sowuinfo@cs.tu-berlin.de)                              #
#                                                                             #
# DESC:   Check the form value from the text_new form. If all ok, insert the  #
#         the text and call the funktion for creating a result page.          #
#                                                                             #
# RETURN: none.                                                               #
#-----------------------------------------------------------------------------#
sub text_add {
  my ($self, $mgr) = @_;

  # Get the input.
  my $text_header     = $mgr->unescape($mgr->{CGI}->param('text_header')) || undef;	
  my $text_desc       = $mgr->unescape($mgr->{CGI}->param('text_desc') )  || undef;	
  my $text_text       = $mgr->unescape($mgr->{CGI}->param('text_text'))   || undef;	
  my $code;

  my $text_lang       = $mgr->{CGI}->param('text_lang');
  my $text_lang_trans = $mgr->{CGI}->param('text_lang_trans');

  if (defined $text_header){$code = $self->Check_Code($mgr, $text_header);}
  if ((defined $text_desc) and ($code<3)){$code = $self->Check_Code($mgr, $text_desc);}
  if ((defined $text_text) and ($code<3)){$code = $self->Check_Code($mgr, $text_text);}

  if ($code==3){
  	$mgr->{TmplData}{TEXT_ERROR} = $mgr->{Func}->get_text($mgr, 8002);
	$mgr->{TmplData}{TEXT_HEADER} = $mgr->escape($text_header);
	$mgr->{TmplData}{TEXT_DESC}   = $mgr->escape($text_desc);
	$mgr->{TmplData}{TEXT_TEXT}   = $mgr->escape($text_text);
   	$self->text_new($mgr, "WrongCode");

   }else{
	my @length_header = split(' ', $text_header);
	my @length_desc   = split(' ', $text_desc);
	my @length_text   = split(' ', $text_text);

	# Count the words plus three. One for each additonal whitespace.
	my $count_words = $#length_header + $#length_desc + $#length_text + 3;
	my $count_error = 0;

	# Catch and count the errors.
	if (!(defined $text_header)) {
	    $mgr->{TmplData}{TEXT_ERROR_HEADER} = $mgr->{Func}->get_text($mgr, 7007);
	    $count_error++;
	}

	if (!(defined $text_desc)) {
	    $mgr->{TmplData}{TEXT_ERROR_DESC} = $mgr->{Func}->get_text($mgr, 7008);
	    $count_error++;
	}

	if (!(defined $text_text)) {
    $mgr->{TmplData}{TEXT_ERROR_TEXT} = $mgr->{Func}->get_text($mgr, 7009);
    $count_error++;
  }

  if ($text_lang == $text_lang_trans) {
    $mgr->{TmplData}{TEXT_ERROR_LANGS} = $mgr->{Func}->get_text($mgr, 7018);
    $count_error++;
  }

  # If we have one or more errors, we show the text_new form again with the old values.
  if ($count_error) {
    $mgr->{TmplData}{TEXT_ERROR} = $mgr->{Func}->get_text($mgr, 7010);
    $self->text_new($mgr, "change");
    return;
  }

  # Call the function for inserting a text.
  my $points = $self->text_insert($mgr, $count_words, $text_header, $text_desc, 
				  $text_text, $text_lang, $text_lang_trans);

  # If points is -1, the user have not enough points for inserting a text.
  return if (!defined $points || $points == -1);

  # Show the page with the inserting result.

  $mgr->{Session}->set("TextPointsOk", $points);
  $mgr->{Session}->set("TextHeaderOk", $text_header);
  $mgr->{Session}->set("TextDescOk", $text_desc);
  $mgr->{Session}->set("TextTextOk", $text_text);
  $mgr->{Session}->set("TextLangOk", $text_lang);
  $mgr->{Session}->set("TextLangTransOk", $text_lang_trans);

  $self->text_insert_ok($mgr);
}
}

#-----------------------------------------------------------------------------#
# CALL:   $self->show_text_upload($mgr).                                      #
#                                                                             #
#         $mgr = manager object.                                              #
#                                                                             #
# AUTHOR: Sören Wurch (sowuinfo@cs.tu-berlin.de)                              #
#                                                                             #
# DESC:   Show the upload form.                                               #
#                                                                             #
# RETURN: none.                                                               #
#-----------------------------------------------------------------------------#
sub show_text_upload {
  my ($self, $mgr) = @_;

  $mgr->{TmplData}{PAGE_LANG_007001} = $mgr->{Func}->get_text($mgr, 7001);
  $mgr->{TmplData}{PAGE_LANG_007006} = $mgr->{Func}->get_text($mgr, 7006);
  $mgr->{TmplData}{PAGE_LANG_007016} = $mgr->{Func}->get_text($mgr, 7016);

  my $text_header     = $mgr->unescape($mgr->{CGI}->param('text_header'));
  my $text_desc       = $mgr->unescape($mgr->{CGI}->param('text_desc'));
  my $text_text       = $mgr->unescape($mgr->{CGI}->param('text_text'));
  my $text_lang       = $mgr->unescape($mgr->{CGI}->param('text_lang'));
  my $text_lang_trans = $mgr->unescape($mgr->{CGI}->param('text_lang_trans'));

  # Set the form value from the text_new form.
  $mgr->{Session}->set("TextHeader", $text_header);
  $mgr->{Session}->set("TextDesc", $text_desc);
  $mgr->{Session}->set("TextText", $text_text);
  $mgr->{Session}->set("TextLang", $text_lang);
  $mgr->{Session}->set("TextLangTrans", $text_lang_trans);

  # Show the upload form.
  $mgr->{TmplData}{PAGE_TITLE}  = $mgr->{Func}->get_text($mgr, 8004);
  $mgr->{Template} = $mgr->{TmplFiles}->{Text_New_Upload};
  $mgr->{TmplData}{TEXT_BACK} =  $self->get_javascript_url_back();
}

#-----------------------------------------------------------------------------#
# CALL:   $self->text_upload($mgr).                                           #
#                                                                             #
#         $mgr = manager object.                                              #
#                                                                             #
# AUTHOR: Sören Wurch (sowuinfo@cs.tu-berlin.de)                              #
#                                                                             #
# DESC:   Upload the choosen file.                                            #
#                                                                             #
# RETURN: none.                                                               #
#-----------------------------------------------------------------------------#
sub text_upload {
  my ($self, $mgr) = @_;

  my $file_path  = $mgr->{CGI}->param('text_file');
  my $bytes_read = 0;
  my ($buffer, $text);

  # Read 2048 bytes from the choosen file.
  while ($bytes_read = read($file_path, $buffer, 2048)) {
    $text .= $buffer;
  }

  $mgr->{Session}->set("TextText", $text);

  $self->text_new($mgr, "upload_back");
}

#-----------------------------------------------------------------------------#
# CALL:   $self->text_insert($mgr, $count_words, $text_header, $text_desc,    #
#                            $text_text, $text_lang, $text_lang_trans).       #
#                                                                             #
#         $mgr             = manager object.                                  #
#         $count_words     = number of words.                                 #
#         $text_header     = the header.                                      #
#         $text_desc       = the description.                                 #
#         $text_text       = the text.                                        #
#         $text_lang       = source language.                                 #
#         $text_lang_trans = destination language.                            #
#                                                                             #
# AUTHOR: Sören Wurch (sowuinfo@cs.tu-berlin.de)                              #
#                                                                             #
# DESC:   Inserting a text in the database, if the user has enough points.    #
#                                                                             #
# RETURN: $points or -1.                                                      #
#-----------------------------------------------------------------------------#
sub text_insert {
  my ($self, $mgr, $count_words, $text_header, 
      $text_desc, $text_text, $text_lang, $text_lang_trans) = @_;

  # Update the points for the number of words.
  my $points = $mgr->{Points}->receive_text($mgr, $mgr->{UserData}->{UserId}, $count_words);
  my $cat_id = $mgr->{Session}->get("TextCatId");

  # If points -1, the user has not enough points for this text.
  if ($points == -1) {
    $mgr->{TmplData}{TEXT_ERROR} = sprintf("%s %s",
					   $mgr->{Func}->get_text($mgr, 7011),
					   $mgr->{Points}->cost_text($mgr, $count_words));
    $self->text_new($mgr, "change");
    return;
  }

  my $dbh = $mgr->connect();

  unless ($dbh->do(sprintf("LOCK TABLES %s WRITE, %s WRITE",
			     $mgr->{Tables}->{CATS}, $mgr->{Tables}->{TEXT}))) {
    warn sprintf("[Error]: Trouble locking tables [%s] and [%s]. Reason: [%s].",
		 $mgr->{Tables}->{CATS}, $mgr->{Tables}->{TEXT}, $dbh->errstr);
    $mgr->fatal_error("Database error.");
  }

  # Insert the text in the database.
  my $sth = $dbh->prepare(sprintf("INSERT INTO %s (text_header, text_desc, text_content,
                                                   num_words, lang_id, lang_trans_id, user_id,
                                                   category_id)
                                   VALUES (?, ?, ?, ?, ?, ?, ?, ?)", $mgr->{Tables}->{TEXT}));

  unless ($sth->execute($text_header, $text_desc, $text_text, $count_words, $text_lang, 
                        $text_lang_trans, $mgr->{UserData}->{UserId}, $cat_id)) {
    warn sprintf("[Error]: Trouble inserting data into table [%s]. Reason: [%s].",
		$mgr->{Tables}->{TEXT}, $dbh->errstr);
    $mgr->fatal_error("Database error.");
  }

  # Update the count of text in the category.
  unless ($dbh->do(sprintf("UPDATE %s SET text_count = text_count + 1 WHERE cat_id = '%s'",
			   $mgr->{Tables}->{CATS}, $cat_id))) {
    warn sprintf("[Error]: Trouble updating data into table [%s]. Reason: [%s].",
		$mgr->{Tables}->{CATS}, $dbh->errstr);
    $mgr->fatal_error("Database error.");
  }

  $dbh->do("UNLOCK TABLES");
  $sth->finish();

  return $points;
}

#-----------------------------------------------------------------------------#
# CALL:   $self->text_insert($mgr, $count_words, $text_header, $text_desc,    #
#                            $text_text, $text_lang, $text_lang_trans).       #
#                                                                             #
#         $mgr             = manager object.                                  #
#         $count_words     = number of words.                                 #
#         $text_header     = the header.                                      #
#         $text_desc       = the description.                                 #
#         $text_text       = the text.                                        #
#         $text_lang       = source language.                                 #
#         $text_lang_trans = destination language.                            #
#                                                                             #
# AUTHOR: Sören Wurch (sowuinfo@cs.tu-berlin.de)                              #
#                                                                             #
# DESC:   If the insert of the text was ok, return a result page.             #
#                                                                             #
# RETURN: none.                                                               #
#-----------------------------------------------------------------------------#
sub text_insert_ok {
my ($self, $mgr) = @_;

my $count_words 	= $mgr->{Session}->get("TextPointsOk");

my $text_header 	= $mgr->{Session}->get("TextHeaderOk");
my $text_desc 		= $mgr->{Session}->get("TextDescOk");
my $text_text 		= $mgr->{Session}->get("TextTextOk");

my $text_lang 		= $mgr->{Session}->get("TextLangOk");
my $text_lang_trans	= $mgr->{Session}->get("TextLangTransOk");

  my $cat_id = $mgr->{Session}->get("TextCatId");

  my @cat = $mgr->{Func}->get_cat($mgr, $cat_id);

  $mgr->{TmplData}{TEXT_ERROR}           = $mgr->{Func}->get_text($mgr, 7013);
  $mgr->{TmplData}{TEXT_BACK}            = $mgr->my_url(ACTION => "home"); #$self->get_javascript_url_back();
  $mgr->{TmplData}{PAGE_LANG_007001}     = $mgr->{Func}->get_text($mgr, 7001);
  $mgr->{TmplData}{PAGE_LANG_007000}     = $mgr->{Func}->get_text($mgr, 7000);
  $mgr->{TmplData}{TEXT_CAT_NAME}        = $cat[2];
  $mgr->{TmplData}{CAT_LINK}		 = $mgr->my_url(ACTION => "text", METHOD => "show_texts") . '&cat_id=' . $cat_id;
  $mgr->{TmplData}{PAGE_LANG_007002}     = $mgr->{Func}->get_text($mgr, 7002);
  $mgr->{TmplData}{PAGE_LANG_007003}     = $mgr->{Func}->get_text($mgr, 7003);
  $mgr->{TmplData}{PAGE_LANG_007004}     = $mgr->{Func}->get_text($mgr, 7004);
  $mgr->{TmplData}{PAGE_LANG_007012}     = $mgr->{Func}->get_text($mgr, 7012);
  $mgr->{TmplData}{PAGE_LANG_007017}     = $mgr->{Func}->get_text($mgr, 7017);

  $mgr->{TmplData}{TEXT_HEADER}          = $mgr->escape($text_header);
  $mgr->{TmplData}{TEXT_DESC}            = $mgr->escape($text_desc);
  $mgr->{TmplData}{TEXT_TEXT}            = $mgr->escape($text_text);

  $mgr->{TmplData}{TEXT_LANG_NAME}       = $mgr->{Func}->get_lang($mgr, $text_lang);
  $mgr->{TmplData}{TEXT_LANG_TRANS_NAME} = $mgr->{Func}->get_lang($mgr, $text_lang_trans);
  $mgr->{TmplData}{TEXT_WORDS}           = $count_words;
  $mgr->{TmplData}{PAGE_LANG_007014}     = $mgr->{Func}->get_text($mgr, 7014);
  $mgr->{TmplData}{TEXT_POINT_COST}      = $mgr->{Points}->cost_text($mgr, $count_words);
  $mgr->{TmplData}{PAGE_LANG_007015}     = $mgr->{Func}->get_text($mgr, 7015);

$mgr->{TmplData}{PAGE_TITLE}  = $mgr->{Func}->get_text($mgr, 8005);

  $mgr->{Template} = $mgr->{TmplFiles}->{Text_New_Ok};


}

#-----------------------------------------------------------------------------#
# CALL:   $self->show_texts($mgr).                                            #
#                                                                             #
#         $mgr = manager object.                                              #
#                                                                             #
# AUTHOR: Sören Wurch (sowuinfo@cs.tu-berlin.de)                              #
#                                                                             #
# DESC:   Show the texts per category.                                        #
#                                                                             #
# RETURN: none.                                                               #
#-----------------------------------------------------------------------------#
sub show_texts {
    my ($self, $mgr) = @_;

    my $cat_id  = $mgr->{CGI}->param('cat_id') || '0';
    my $page_id = $mgr->{CGI}->param('page') || '0';
    $self->fill_text_header($mgr, $cat_id);

    $mgr->{TmplData}{CAT_ID} = $cat_id; #by Hendrik

    my @texts = $mgr->{Func}->get_cat_texts($mgr, $cat_id);
    my $count = 0;
    my @result;

    # Fill the text loop.
    # TODO: Links, Paging ...
    foreach my $text (@texts) {
	$result[$count]{TEXT_SHOW_LINK} = sprintf("%s&text_id=%s", 
						  $mgr->my_url(ACTION => "text",
							       METHOD => "text_show"),
						  $text->[0]
						  );
	$result[$count]{TEXT_HEADER}    = $text->[1];
	$result[$count]{TEXT_DESC}      = $text->[2];
	$result[$count]{TEXT_LANG}      = $mgr->{Func}->get_lang($mgr, $text->[3]);
	$result[$count]{TEXT_AVG_RAT}   = $text->[5];
	$result[$count]{TEXT_NUM_RAT}   = $text->[6];
	$count++;
    }
    
    $mgr->{TmplData}{LOOP_CAT_TEXTS} = \@result;
    $mgr->{Template}                 = $mgr->{TmplFiles}->{Text_Cat_Show};
}

#-----------------------------------------------------------------------------#
# CALL:   $self->fill_text_header($mgr, $cat_id).                             #
#                                                                             #
#         $mgr    = manager object.                                           #
#         $cat_id = category id.                                              #
#                                                                             #
# AUTHOR: Sören Wurch (sowuinfo@cs.tu-berlin.de)                              #
#                                                                             #
# DESC:   Fills the header for the texts per category.                        #
#                                                                             #
# RETURN: none.                                                               #
#-----------------------------------------------------------------------------#
sub fill_text_header {
  my ($self, $mgr, $cat_id) = @_;

  my @cat = $mgr->{Func}->get_cat($mgr, $cat_id);

  $mgr->{TmplData}{PAGE_LANG_000024} = $mgr->{Func}->get_text($mgr, 24);
  $mgr->{TmplData}{PAGE_LANG_000025} = $mgr->{Func}->get_text($mgr, 25);
  $mgr->{TmplData}{PAGE_LANG_000026} = $mgr->{Func}->get_text($mgr, 26);
  $mgr->{TmplData}{PAGE_LANG_000027} = $mgr->{Func}->get_text($mgr, 27);
  $mgr->{TmplData}{PAGE_LANG_007001} = $mgr->{Func}->get_text($mgr, 7001);
  $mgr->{TmplData}{TEXT_CAT_NAME}    = $cat[2];
  $mgr->{TmplData}{PAGE_LANG_007000} = $mgr->{Func}->get_text($mgr, 7000);
  $mgr->{TmplData}{TEXT_CAT_BACK}    = $mgr->my_url(ACTION => "home");
}

sub get_text {
  my ($self, $mgr, $text_id) = @_;

  my $table_text = $mgr->{Tables}->{TEXT};
  my $dbh        = $mgr->connect();

  my $sth        = $dbh->prepare(<<SQL);

SELECT t.category_id, t.lang_id, t.text_header, t.text_desc, t.text_content, parent_id
FROM   $table_text t
WHERE  t.text_id = ?

SQL

  unless ($sth->execute($text_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s] and [%s].".
	         "Reason: [%s].", $table_text, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }

  my @text = $sth->fetchrow_array();

  $sth->finish();

  return @text;
}

sub get_text_lang_in_text{
my ($self, $mgr, $text_id) = @_;

my $table = $mgr->{Tables}->{TEXT};
my $dbh        = $mgr->connect();
my $sth        = $dbh->prepare(<<SQL);

SELECT lang_id
FROM   $table
WHERE  text_id = ? OR parent_id = ?

SQL

  unless ($sth->execute($text_id, $text_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s] and [%s].".
	         "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }

  my @text_langs;
	while (my $lang_id  = $sth->fetchrow_array()) {

	push (@text_langs, $lang_id);    
  }

  $sth->finish();

  return @text_langs;
}

sub get_text_langs {
  my ($self, $mgr, $text_id) = @_;

  my $table = $mgr->{Tables}->{TEXT};

  my $dbh        = $mgr->connect();

# Search languages in Table_Text
  #prüfe ob Übersetzung oder Original Text
  my $sth        = $dbh->prepare(<<SQL);

SELECT parent_id
FROM   $table
WHERE  text_id = ?

SQL

  unless ($sth->execute($text_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s] and [%s].".
	         "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }

my $parent_id = $sth->fetchrow_array();
my $search_id;
my $is_orig;
my @text_langs;
my @text_ids;

#setze ID zu suchen
if ($parent_id > 0){ 
	$search_id = $parent_id;
	$is_orig = 0;
}else{ 
	$search_id = $text_id; 
	$is_orig = 1;
}

#Suche alle Sprachen in Table_Text
if ($is_orig == 1){
#Originaler Text
$sth = $dbh->prepare(<<SQL);

SELECT lang_id
FROM   $table
WHERE  text_id = ? OR parent_id = ?

SQL

  unless ($sth->execute($search_id, $search_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s] and [%s].".
	         "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }

	while (my $lang_id  = $sth->fetchrow_array()) {
		push (@text_langs, $lang_id);    
	}
}else{
#Übersetzung
$sth = $dbh->prepare(<<SQL);

SELECT lang_id, text_id
FROM   $table
WHERE  text_id = ? OR parent_id = ?

SQL

  unless ($sth->execute($search_id, $search_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s] and [%s].".
	         "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }

	while (my ($lang_id, $text_text_id ) = $sth->fetchrow_array()) {
		push (@text_langs, $lang_id);    
		push (@text_ids, $text_text_id);
	}

}# Ende Search language in Table_text


$table = $mgr->{Tables}->{TEXT_RES};

#Suche in Text_Res------------------
if ($is_orig == 1){
#Originaler Text

$sth        = $dbh->prepare(<<SQL);

SELECT lang_trans_id 
FROM   $table
WHERE  text_id = ? AND art='2'

SQL


  unless ($sth->execute($text_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s] and [%s].".
	         "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }

	while (my $lang_id  = $sth->fetchrow_array()) {
	push (@text_langs, $lang_id);    
  }

}else{
#Übersetzung

my $select_condition;
my $id;
	foreach $id (@text_ids) {
	
$sth        = $dbh->prepare(<<SQL);

SELECT lang_trans_id 
FROM   $table
WHERE  text_id = ? AND art='2'

SQL


  unless ($sth->execute($id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s] and [%s].".
	         "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }

	while (my $lang_id  = $sth->fetchrow_array()) {
		push (@text_langs, $lang_id);    
	}



     }#Ende foreach


}#Ende search languages in Text_res


  $sth->finish();

  return @text_langs;
}

sub text_trans_insert{
my $self 		= shift;
my $mgr  		= shift;
my $trans_head 		= $mgr->unescape(shift) || undef;
my $trans_desc 		= $mgr->unescape(shift) || undef;
my $trans_text 		= $mgr->unescape(shift) || undef;
my $text_id 		= shift || undef;
my $trans_lang 		= shift || undef;
my $text_header		= $mgr->escape(shift) || undef;
my $text_lang		= shift || undef;

my @length_header = split(' ', $trans_head);
my @length_desc   = split(' ', $trans_desc);
my @length_text   = split(' ', $trans_text);

my $count_words = $#length_header + $#length_desc + $#length_text + 3;

my $translator_id = $mgr->{UserData}->{UserId} || undef;

my $cat_id 	= $mgr->{Session}->get("TextTransCatID") || undef;
my $trans_data 	= $mgr->{Session}->get("TextTransArt")   || undef;
my $parent_text_id = $mgr->{Session}->get("TextTransParentID") || undef;

if ($parent_text_id > 0){$text_id = $parent_text_id;}

my ($trans_art, $text_res_id, $res_id);

my $translation_id ;

my $text_table;
my $cats_table;
my $dbh;
my $sth;
my $table;
my $points;

if (defined $trans_data) {
	my @trans_data = split('/', $trans_data);
	$trans_art = $trans_data[0]; 
	$text_res_id = $trans_data[1];
	$res_id = $trans_data[2];
}


$mgr->{Session}->del("TextTransCatID");
$mgr->{Session}->del("TextTransArt");

#enregistre la traduction
if ( ($text_id) and ($trans_head ) and ($trans_desc ) and ($trans_text ) and ($trans_lang) and ($translator_id) and ($cat_id)){

	$dbh = $mgr->connect();

	$text_table = $mgr->{Tables}->{TEXT};
	$cats_table = $mgr->{Tables}->{CATS};
	
	unless ( $dbh->do("LOCK TABLES $text_table WRITE, $cats_table WRITE"))
	{
		warn sprintf("[Error]: Trouble locking tables %s and %s " .
			"Reason: [%s].",  $text_table, $cats_table, $dbh->errstr());
			$dbh->do("UNLOCK TABLES");
			$mgr->fatal_error("Database error.");
	}



	$sth = $dbh->prepare(sprintf("INSERT INTO %s (parent_id, text_header, text_desc, text_content,
                                                   num_words, lang_id, user_id, category_id) 
                                   VALUES (?, ?, ?, ?, ?, ?, ?, ?)", $text_table));

	unless ($sth->execute($text_id, $trans_head, $trans_desc, $trans_text, $count_words, $trans_lang, $translator_id, $cat_id)) 
	{
		warn sprintf("[Error]: Trouble inserting data into table [%s]. Reason: [%s].",
		$text_table, $dbh->errstr);
		$mgr->fatal_error("Database error.");
	}


	unless ($dbh->do(sprintf("UPDATE %s SET text_count = text_count + 1 WHERE cat_id = '%s'",
				$cats_table, $cat_id))) {
		warn sprintf("[Error]: Trouble updating data into table [%s]. Reason: [%s].",
		$cats_table, $dbh->errstr);
		$mgr->fatal_error("Database error.");
	}

	$dbh->do("UNLOCK TABLES");
	$sth->finish();

	$translation_id = $sth->{mysql_insertid};
}else{return;}
#FIN Traduction

#Effacer la traduction chez le Benutzer
if ((defined $trans_art) and (defined $text_res_id) and ($trans_art == 2) and ($text_res_id == $text_id)) {
	$table = $mgr->{Tables}->{TEXT_RES};
	$dbh = $mgr->connect();

	unless ( $dbh->do("LOCK TABLES $table WRITE"))
	{
		warn sprintf("[Error]: Trouble locking tables %s." .
			"Reason: [%s].",  $table, $dbh->errstr());
			$dbh->do("UNLOCK TABLES");
			$mgr->fatal_error("Database error.");
	}


$sth = $dbh->prepare(<<SQL);

DELETE LOW_PRIORITY
FROM   $table
WHERE  res_id = ?

SQL
	
	unless ($sth->execute($res_id)) 
	{
	    warn sprintf("[Error:] Trouble selecting data from [%s].".
	                "Reason: [%s].", $table, $dbh->errstr());
		$dbh->do("UNLOCK TABLES");
		$mgr->fatal_error("Database error.");
	}

	$dbh->do("UNLOCK TABLES");
	$sth->finish();

}
#FIN d'effacer

#Punkte aktualisieren
$points = $mgr->{Points}->receive_trans($mgr, $translator_id, $count_words, $translation_id);

#Mot a l'auteur
$table = $mgr->{Tables}->{TEXT_RES};
$text_table = $mgr->{Tables}->{TEXT};

$dbh        = $mgr->connect();

unless ( $dbh->do("LOCK TABLES $table WRITE, $text_table WRITE"))
{
	warn sprintf("[Error]: Trouble locking tables %s and %s" .
		"Reason: [%s].",  $table, $text_table, $dbh->errstr());
		$dbh->do("UNLOCK TABLES");
		$mgr->fatal_error("Database error.");
}

#----- cherche l'id de l'auteur
$sth        = $dbh->prepare(<<SQL);

SELECT user_id
FROM   $text_table
WHERE  text_id = ?

SQL

unless ($sth->execute($text_id)) {
	warn sprintf("[Error:] Trouble selecting data from [%s].".
	         "Reason: [%s].", $text_table, $dbh->errstr());
    	$mgr->fatal_error("Database error.");
}

my $autor_id = $sth->fetchrow_array();



#-------- ecris le mot dans la table text_reserve
$sth = $dbh->prepare(sprintf("INSERT INTO %s (text_id, lang_trans_id, user_id, art) 
                                   VALUES (?, ?, ?, ?)", $table));

unless ($sth->execute($text_id, $trans_lang, $autor_id, '4')) {
	warn sprintf("[Error]: Trouble inserting data into table [%s]. Reason: [%s].",
		$table, $dbh->errstr);
		$mgr->fatal_error("Database error.");
}

$dbh->do("UNLOCK TABLES");
$sth->finish();
# FIN

#montre la confirmation
$mgr->{Session}->set("TransTransWordsOk", $count_words);
$mgr->{Session}->set("TransTextTransHeaderOk", $trans_head);
$mgr->{Session}->set("TransTextHeaderOk", $text_header);
$mgr->{Session}->set("TransTextCatOk", $cat_id);
$mgr->{Session}->set("TransTextLangOk", $text_lang);
$mgr->{Session}->set("TransTransLangTransOk", $trans_lang);
$mgr->{Session}->set("TransTransPointsOk", $points);
$mgr->{Session}->set("TransTextIDOk", $text_id);

$self->text_trans_insert_ok($mgr);

}

sub text_trans {

my $self = shift;
my $mgr  = shift;
my $mode = shift || '';
my $t_id   = shift || undef;
my $t_lang = shift || undef;

my $text_id = $mgr->{CGI}->param('text_to_trans_id') || undef;

my $show_this_tmpl = 1;
my $trans_lang;

my $trans_head;
my $trans_desc;
my $trans_text;


if (($mode eq "upload_back1") or ($mode eq "upload_back2") or (defined $mgr->{CGI}->param('change_lang')) ) {

	$trans_lang = $mgr->{Session}->get("TransLang");
	$mgr->{Session}->del("TransLang");

}elsif (($mode eq "online_trans") and (defined $t_id)){

	$text_id = $t_id;
	if (defined $t_lang){ $trans_lang = $t_lang;}

}else{
	$trans_lang = $mgr->{CGI}->param('trans_lang') || '1';
}



#$text_id =1;


if (defined $text_id ){

	my @text_array = $self->get_text($mgr, $text_id);

	if ($mode eq "upload_back1") {
	#zurück von Uploaden mit Text
			
	$mgr->{TmplData}{TEXT_TRANS_HEADER} = $mgr->escape($mgr->{Session}->get("TextTransHead"));
	$mgr->{TmplData}{TEXT_TRANS_DESC}   = $mgr->escape($mgr->{Session}->get("TextTransDesc"));
	$mgr->{TmplData}{TEXT_TRANS_TEXT}   = $mgr->escape($mgr->{Session}->get("TextTransText"));

	$mgr->{Session}->del("TextTransHead");
	$mgr->{Session}->del("TextTransDesc");
	$mgr->{Session}->del("TextTransText");

	#}elsif ($mode eq "upload_back2") {
	#zurück von Uploaden ohne Text


	} elsif  (defined $mgr->{CGI}->param('show_text_trans_upload')){
	#zu Uploaden
		$mgr->{Session}->set("TransLang", $trans_lang);
		
		$self->show_text_trans_upload($mgr, $text_id);
		$show_this_tmpl=0;

	}elsif (defined $mgr->{CGI}->param('change_lang')) { 
	#changer la langue

		$trans_head = $mgr->{CGI}->param('text_trans_header') || '';
		$trans_desc = $mgr->{CGI}->param('text_trans_desc')   || '';
		$trans_text = $mgr->{CGI}->param('text_trans_text')   || '';


		$mgr->{TmplData}{TEXT_TRANS_HEADER} = $mgr->escape($trans_head);
		$mgr->{TmplData}{TEXT_TRANS_DESC}   = $mgr->escape($trans_desc);
		$mgr->{TmplData}{TEXT_TRANS_TEXT}   = $mgr->escape($trans_text);


	}elsif(defined $mgr->{CGI}->param('text_trans_add')){
	#save translation

		my @text_langs_check =   $self->get_text_langs($mgr, $text_id);

		my $error_count = 0;
		$trans_head = $mgr->{CGI}->param('text_trans_header') || undef;
		$trans_desc = $mgr->{CGI}->param('text_trans_desc')    || undef;
		$trans_text = $mgr->{CGI}->param('text_trans_text')   || undef;
		
		 if (grep(/$trans_lang/, @text_langs_check )){ 		

			my $trans_data 	= $mgr->{Session}->get("TextTransArt")   || undef;
			my ($trans_art, $text_res_id, $res_id);
	
			if (defined $trans_data) {
				my @trans_data = split('/', $trans_data);
				$trans_art = $trans_data[0]; 
				$text_res_id = $trans_data[1];
				$res_id = $trans_data[2];
			}
			#encore checke dans le DB
			my @text_lang_in_text = $self->get_text_lang_in_text($mgr, $text_id);

			if (!((defined $text_res_id ) and ($text_res_id == $text_id) and (!(grep(/$trans_lang/, @text_lang_in_text))) )){
				my $wrong_lang_name = $mgr->{Func}->get_lang($mgr, $trans_lang);
				$mgr->{TmplData}{TEXT_TRANS_LANG_ERROR}  = $mgr->{Func}->get_text($mgr, 8024);
				$error_count++; 
			}	
		}


		if (!(defined $trans_head)){
			$mgr->{TmplData}{TEXT_TRANS_HEADER_ERROR} = $mgr->{Func}->get_text($mgr, 8025);
			$error_count++; }
		
		if (!(defined $trans_desc)){
			$mgr->{TmplData}{TEXT_TRANS_DESC_ERROR} = $mgr->{Func}->get_text($mgr, 8026);
			$error_count++; }
		
		if (!(defined $trans_text)){
			$mgr->{TmplData}{TEXT_TRANS_TEXT_ERROR}  = $mgr->{Func}->get_text($mgr, 8027);
			$error_count++; }

		if ($error_count>0){
			
			$mgr->{TmplData}{TEXT_TRANS_ERROR}  = $mgr->{Func}->get_text($mgr, 8028);

			$mgr->{TmplData}{TEXT_TRANS_HEADER} = $trans_head ;
			$mgr->{TmplData}{TEXT_TRANS_DESC}   = $trans_desc;
			$mgr->{TmplData}{TEXT_TRANS_TEXT}   = $trans_text;
		}else{

		$self->text_trans_insert($mgr, $trans_head, $trans_desc, $trans_text, $text_id, $trans_lang, $text_array[2], $text_array[1]);
		$show_this_tmpl=0;

		}

	}

	if ( $show_this_tmpl == 1 ){
		#fill normal template
	
		my @cat = $mgr->{Func}->get_cat($mgr, $text_array[0]);

		$mgr->{Session}->set("TextTransCatID", $text_array[0]);
		$mgr->{Session}->set("TextTransParentID", $text_array[5]);

		$mgr->{TmplData}{TEXT_CAT}    = $cat[2];
		$mgr->{TmplData}{TEXT_LANG}   = $mgr->{Func}->get_lang($mgr, $text_array[1]);
		$mgr->{TmplData}{TEXT_HEADER} = $mgr->escape($text_array[2]);
		$mgr->{TmplData}{TEXT_DESC}   = $mgr->escape($text_array[3]);
		$mgr->{TmplData}{TEXT_TEXT}   = $mgr->escape($text_array[4]);

		$mgr->{TmplData}{PAGE_LANG_007001} = $mgr->{Func}->get_text($mgr, 7001);
		$mgr->{TmplData}{TEXT_BACK} = $self->get_javascript_url_back();
		$mgr->{TmplData}{PAGE_LANG_007000} = $mgr->{Func}->get_text($mgr, 7000);

		$mgr->{TmplData}{PAGE_LANG_007012} = $mgr->{Func}->get_text($mgr, 7012);
		$mgr->{TmplData}{PAGE_LANG_007017} = $mgr->{Func}->get_text($mgr, 7017);
		$mgr->{TmplData}{PAGE_LANG_008007} = $mgr->{Func}->get_text($mgr, 8007);
		$mgr->{TmplData}{PAGE_LANG_008008} = $mgr->{Func}->get_text($mgr, 8008);
		$mgr->{TmplData}{PAGE_LANG_008009} = $mgr->{Func}->get_text($mgr, 8009);
		$mgr->{TmplData}{PAGE_LANG_008010} = $mgr->{Func}->get_text($mgr, 8010);
		$mgr->{TmplData}{PAGE_LANG_008011} = $mgr->{Func}->get_text($mgr, 8011);
		$mgr->{TmplData}{PAGE_LANG_008012} = $mgr->{Func}->get_text($mgr, 8012);
		$mgr->{TmplData}{PAGE_LANG_008013} = $mgr->{Func}->get_text($mgr, 8013);
		$mgr->{TmplData}{PAGE_LANG_008014} = $mgr->{Func}->get_text($mgr, 8014);

		$mgr->{TmplData}{PAGE_METHOD} = 'text_trans';
		$mgr->{TmplData}{PAGE_TITLE} = $mgr->{Func}->get_text($mgr, 8006);

		$mgr->{TmplData}{TEXT_TO_TRANS_ID} = $text_id;

		$mgr->{Session}->set("TextTransCatID", $text_array[0]);
		my $trans_data 	= $mgr->{Session}->get("TextTransArt")   || undef;
		my ($trans_art, $text_res_id, $res_id);
		my @lang_result;
		my $get_other_lang = 1;

		if (defined $trans_data) {
			my @trans_data = split('/', $trans_data);
			$trans_art = $trans_data[0]; 
			$text_res_id = $trans_data[1];
			$res_id = $trans_data[2];
			
			if (($trans_art == 2) and ($text_res_id == $text_id)) {
				$get_other_lang = 0;
				$lang_result[0]{TEXT_TRANS_LANG_ID}         = $trans_lang;
		    		$lang_result[0]{TEXT_TRANS_LANG_NAME}       = $mgr->{Func}->get_lang($mgr, $trans_lang);
			}				
		}

	   if($get_other_lang == 1){

		my @langs      = $mgr->{Func}->get_langs($mgr);
		my @text_langs =   $self->get_text_langs($mgr, $text_id);
		my @langs_array;
		my $lang;
		
		foreach $lang (@langs) {

			if (!(grep(/$lang->[0]/, @text_langs))){ 		
				push(@langs_array, $lang);
			}
		}

		my $lang_count = 0;

		foreach my $lang (@langs_array) {
			if ($lang->[0] == $trans_lang) {
				$lang_result[$lang_count]{TEXT_TRANS_LANG_IF} = 1;
			}

			$lang_result[$lang_count]{TEXT_TRANS_LANG_ID}         = $lang->[0];
	    		$lang_result[$lang_count]{TEXT_TRANS_LANG_NAME}       = $lang->[1];

			$lang_count++;
		}

		@lang_result = sort {$a->{TEXT_TRANS_LANG_NAME} cmp $b->{TEXT_TRANS_LANG_NAME}} @lang_result;
            }

		$mgr->{TmplData}{LOOP_TEXT_TRANS_LANG} = \@lang_result;
		$mgr->{Template}                 = $mgr->{TmplFiles}->{Text_Trans};
	}




}else{	$mgr->{Template}                 = $mgr->{TmplFiles}->{Error};}

}

sub get_javascript_url_back{

return 'window.history.go(-1)';

}



sub show_text_trans_upload{
my $self = shift;
my $mgr  = shift;
my $text_id = shift || $mgr->{CGI}->param('text_to_trans_id');

my $upload_file  = $mgr->{CGI}->param('text_trans_file') || undef;
my $bytes_read = 0;
my ($buffer, $text);
my $show_this_tmpl = 1;
my $code;

if (defined $upload_file){

	while ($bytes_read = read($upload_file, $buffer, 2048)) {
		$text .= $buffer;
	}

	if (defined $text){$code = $self->Check_Code($mgr, $text);}

	if ($code==3){ 
		$mgr->{TmplData}{TEXT_TRANS_UPLOAD_ERROR} = $mgr->{Func}->get_text($mgr, 8029);
	}else{
	my @text_array = split('XXXXX', $text);
	
		if ($#text_array != 2){
			$mgr->{TmplData}{TEXT_TRANS_ERROR} = $mgr->{Func}->get_text($mgr, 8030);
			$show_this_tmpl = 0;
			$self->text_trans($mgr, "upload_back2");
					
		}else{
			my $trans_head = $text_array[0] ;
			my $trans_desc = $text_array[1] ;
			my $trans_text = $text_array[2] ;

			$show_this_tmpl = 0;
			$mgr->{Session}->set("TextTransHead", $trans_head);
			$mgr->{Session}->set("TextTransDesc", $trans_desc);
			$mgr->{Session}->set("TextTransText", $trans_text);
			$self->text_trans($mgr, "upload_back1");
		}
	}

}else{
	if (defined $mgr->{CGI}->param('text_trans_upload')){
		$mgr->{TmplData}{TEXT_TRANS_ERROR} = $mgr->{Func}->get_text($mgr, 8031);
		$show_this_tmpl = 0;
		$self->text_trans($mgr, "upload_back2");
	}

}


if ($show_this_tmpl ==1){
	$mgr->{TmplData}{PAGE_METHOD} = 'text_trans_upload';
	$mgr->{Template} = $mgr->{TmplFiles}->{Text_Trans_Upload};
	$mgr->{TmplData}{TEXT_TO_TRANS_ID} = $text_id;

	$mgr->{TmplData}{PAGE_TITLE}  = $mgr->{Func}->get_text($mgr, 8015);
	$mgr->{TmplData}{PAGE_LANG_007001} = $mgr->{Func}->get_text($mgr, 7001);
	$mgr->{TmplData}{TEXT_BACK} = $self->get_javascript_url_back();

	$mgr->{TmplData}{PAGE_LANG_007016} = $mgr->{Func}->get_text($mgr, 7016);
	$mgr->{TmplData}{PAGE_LANG_007006} = $mgr->{Func}->get_text($mgr, 7006);

	$mgr->{TmplData}{TEXT_TO_TRANS_ID} = $text_id;
}

}


sub text_trans_insert_ok {
my ($self, $mgr) = @_;

my $count_words 	= $mgr->{Session}->get("TransTransWordsOk");
my $trans_header 	= $mgr->{Session}->get("TransTextTransHeaderOk");
my $text_header 	= $mgr->{Session}->get("TransTextHeaderOk");
my $cat_id 		= $mgr->{Session}->get("TransTextCatOk");
my $text_lang 		= $mgr->{Session}->get("TransTextLangOk");
my $trans_lang  	= $mgr->{Session}->get("TransTransLangTransOk");
my $points  		= $mgr->{Session}->get("TransTransPointsOk");
my $text_id 		= $mgr->{Session}->get("TransTextIDOk");

my @cat = $mgr->{Func}->get_cat($mgr, $cat_id);


  $mgr->{TmplData}{TEXT_TRANS_ERROR}   	 = $mgr->{Func}->get_text($mgr, 8032);
  $mgr->{TmplData}{TEXT_BACK} 		 = $mgr->my_url(ACTION => "text", METHOD => "text_show") . '&text_id=' . $text_id;
  $mgr->{TmplData}{PAGE_LANG_007001}     = $mgr->{Func}->get_text($mgr, 7001);
  $mgr->{TmplData}{PAGE_LANG_007000}     = $mgr->{Func}->get_text($mgr, 7000);
  $mgr->{TmplData}{PAGE_LANG_007012}     = $mgr->{Func}->get_text($mgr, 7012);
  $mgr->{TmplData}{PAGE_LANG_007017}     = $mgr->{Func}->get_text($mgr, 7017);
  $mgr->{TmplData}{PAGE_LANG_007014}     = $mgr->{Func}->get_text($mgr, 7014);
  $mgr->{TmplData}{PAGE_LANG_008047}     = $mgr->{Func}->get_text($mgr, 8047);
  $mgr->{TmplData}{PAGE_LANG_008007}     = $mgr->{Func}->get_text($mgr, 8007);
  $mgr->{TmplData}{PAGE_LANG_008008}     = $mgr->{Func}->get_text($mgr, 8008);



  $mgr->{TmplData}{TEXT_CAT_NAME}        = $cat[2];
  $mgr->{TmplData}{CAT_LINK}		 = $mgr->my_url(ACTION => "text", METHOD => "show_texts") . '&cat_id=' . $cat_id;
  $mgr->{TmplData}{TEXT_HEADER}          = $mgr->escape($text_header);
  $mgr->{TmplData}{TRANS_HEADER}         = $mgr->escape($trans_header);
  $mgr->{TmplData}{TEXT_LANG_NAME}       = $mgr->{Func}->get_lang($mgr, $text_lang);
  $mgr->{TmplData}{TEXT_TRANS_LANG_NAME} = $mgr->{Func}->get_lang($mgr, $trans_lang);
  $mgr->{TmplData}{TRANS_WORDS}           = $count_words;
  $mgr->{TmplData}{TRANS_POINT}      = $points ;


  #$mgr->{TmplData}{PAGE_TITLE}  = $mgr->{Func}->get_text($mgr, 8005);
  $mgr->{Template} = $mgr->{TmplFiles}->{Text_Trans_Ok};
   $mgr->{TmplData}{PAGE_METHOD} = 'text_trans_insert_ok';

}



sub delete_trans_res {
my ($self, $mgr) = @_;
my $res_id = $mgr->{CGI}->param('res_id') || undef;
my $res_art = $mgr->{CGI}->param('art') || undef;
my $text_id = $mgr->{CGI}->param('text_id') || undef;
my $trans_lang = $mgr->{CGI}->param('trans_lang') || undef;

if (($res_id) and ($res_art) and ($text_id) and ($trans_lang)) {

my $dbh = $mgr->connect();
my $table = $mgr->{Tables}->{TEXT_RES};
my $sth;

if ($res_art == 2){

#Mot a autor
#--------------get_autor
my $text_table = $mgr->{Tables}->{TEXT};
my $search = 1;
my $new_text_id = $text_id;
my ($actual_text_id, $parent_id, $autor_id);


while ($search == 1){

$sth = $dbh->prepare(<<SQL);

SELECT text_id, parent_id, user_id
FROM   $text_table
WHERE  text_id = ?

SQL

unless ($sth->execute($new_text_id)) {
	warn sprintf("[Error:] Trouble selecting data from [%s].".
	         "Reason: [%s].", $text_table, $dbh->errstr());
    	$mgr->fatal_error("Database error.");
}

($actual_text_id, $parent_id, $autor_id) = $sth->fetchrow_array();

if ($parent_id == 0){	
	$search = 0;
}else{
	$new_text_id =  $parent_id;
}
} #End while


unless ( $dbh->do("LOCK TABLES $table WRITE"))
 {
	warn sprintf("[Error]: Trouble locking tables %s." .
		"Reason: [%s].",  $table, $dbh->errstr());
		$dbh->do("UNLOCK TABLES");
		$mgr->fatal_error("Database error.");
	}



$sth = $dbh->prepare(<<SQL);

INSERT INTO $table (text_id, lang_trans_id, user_id, art) 
VALUES (?, ?, ?, ?)

SQL

unless ($sth->execute($actual_text_id, $trans_lang, $autor_id, '5')) {
	warn sprintf("[Error:] Trouble insert data in [%s].".
	         "Reason: [%s].", $table, $dbh->errstr());
    	$mgr->fatal_error("Database error.");
}



} #end if / mot a autor

unless ( $dbh->do("LOCK TABLES $table WRITE"))
 {
	warn sprintf("[Error]: Trouble locking tables %s." .
		"Reason: [%s].",  $table, $dbh->errstr());
		$dbh->do("UNLOCK TABLES");
		$mgr->fatal_error("Database error.");
	}



$sth = $dbh->prepare(<<SQL);

DELETE LOW_PRIORITY
FROM   $table
WHERE  res_id = ?

SQL

	unless ($sth->execute($res_id)) 
	{
	    warn sprintf("[Error:] Trouble selecting data from [%s].".
	                "Reason: [%s].", $table, $dbh->errstr());
		$dbh->do("UNLOCK TABLES");
		$mgr->fatal_error("Database error.");
	}


	$dbh->do("UNLOCK TABLES");
	$sth->finish();
}


$self->show_text_user_message($mgr);

}



sub res_trans_upload {
my ($self, $mgr) = @_;
my $res_id  = $mgr->{CGI}->param('res_id') || undef;
my $res_text_id = $mgr->{CGI}->param('text_id') || undef;
my $trans_lang_id = $mgr->{CGI}->param('trans_lang') || undef;
my $res_art = '2';

if (($res_id) and ($res_text_id)){
	#merken in Session
	my $trans_data 	= $res_art ."/" . $res_text_id   ."/". $res_id;
	$mgr->{Session}->set("TextTransArt", $trans_data );


	#show text_trans_upload
	$mgr->{Session}->set("TransLang", $trans_lang_id);
	$self->show_text_trans_upload($mgr, $res_text_id);
}else{
	$mgr->{Template} = $mgr->{TmplFiles}->{Error};
}

}

sub time_string
{
    my ($self, $time) = @_;
    
my $year = substr($time, 2, 2);
my $mon  = substr($time, 4, 2);
my $day  = substr($time, 6, 2);

     return "$day.$mon.$year";
}   

sub get_text_link{
my ($self, $mgr, $method ,$text_id) = @_;

my $link = sprintf("%s?action=%s&lang=%s&sid=%s&method=%s&text_id=%s",
			$mgr->{ScriptName},
			$mgr->{Action},
			$mgr->{SystemLangs}->{$mgr->{Language}},
			$mgr->{SessionId}, 
			$method, 
			$text_id);

  return $link;
}

sub show_text_user_message{
my ($self, $mgr) = @_;
my $user_id = $mgr->{UserData}->{UserId};

my $table = $mgr->{Tables}->{TEXT_RES};
my $text_table = $mgr->{Tables}->{TEXT};

my $dbh = $mgr->connect();

my $sth = $dbh->prepare(<<SQL);

SELECT r.res_id, r.text_id, r.lang_trans_id, r.submit_time, r.art, t.text_header 
FROM   $text_table t , $table r 
WHERE  r.user_id = ? AND r.text_id = t.text_id

SQL

unless ($sth->execute($user_id)) {
	warn sprintf("[Error:] Trouble selecting data from [%s] and [%s].".
	         "Reason: [%s].", $text_table, $table, $dbh->errstr());
    	$mgr->fatal_error("Database error.");
}

my @loop_data;
my $counter = 0;

while (my ($res_id, $text_id, $lang_trans_id, $submit_time, $art, $text_header ) = $sth->fetchrow_array()) {

$loop_data[$counter]{TEXT_RES_DATE} = $self->time_string($submit_time);
$loop_data[$counter]{TEXT_HEADER}   =  $mgr->escape($text_header);
$loop_data[$counter]{TEXT_HEADER_LINKS} = $self->get_text_link($mgr,'text_show',$text_id);
my $lan_name = $mgr->{Func}->get_lang($mgr, $lang_trans_id);

	if ($art == 0){

		$loop_data[$counter]{TEXT_RES_MES}  =  $mgr->{Func}->get_text($mgr, 8036);
		$loop_data[$counter]{TEXT_FUNC_DELETE} = $mgr->{Func}->get_text($mgr, 8033);
		$loop_data[$counter]{TEXT_MES_DELETE_LINKS} = $self->get_delete_link($mgr, 'delete_trans_res', $res_id, $art, $text_id, $lang_trans_id);
#		$loop_data[$counter]{ROW_COLOR} = 'teal';

	}elsif($art == 1){

		$loop_data[$counter]{TEXT_RES_MES}  =  $mgr->{Func}->get_text($mgr, 8037);
		$loop_data[$counter]{TEXT_FUNC_DELETE} = $mgr->{Func}->get_text($mgr, 8033);
		$loop_data[$counter]{TEXT_MES_DELETE_LINKS} = $self->get_delete_link($mgr, 'delete_trans_res', $res_id, $art, $text_id, $lang_trans_id);
#		$loop_data[$counter]{ROW_COLOR} = 'teal';

	}elsif($art == 2){

		$loop_data[$counter]{TEXT_RES_MES}  =  $mgr->{Func}->get_text($mgr, 8038) . ' ' . "$lan_name";
		$loop_data[$counter]{TEXT_FUNC_UPLOAD} = $mgr->{Func}->get_text($mgr, 8034);
		$loop_data[$counter]{TEXT_MES_UPLOAD_LINKS} = $self->get_upload_link($mgr, 'res_trans_upload', $res_id, $text_id, $lang_trans_id);

		$loop_data[$counter]{TEXT_FUNC_DEBLOCK} = $mgr->{Func}->get_text($mgr, 8035);
		$loop_data[$counter]{TEXT_MES_DEBLOCK_LINKS} = $self->get_delete_link($mgr, 'delete_trans_res', $res_id, $art, $text_id, $lang_trans_id);

#		$loop_data[$counter]{ROW_COLOR} = 'red';

	}elsif($art == 3){

		$loop_data[$counter]{TEXT_RES_MES}  =  $mgr->{Func}->get_text($mgr, 8039) . ' ' . "$lan_name";
		$loop_data[$counter]{TEXT_FUNC_DELETE} = $mgr->{Func}->get_text($mgr, 8033);
		$loop_data[$counter]{TEXT_MES_DELETE_LINKS} = $self->get_delete_link($mgr, 'delete_trans_res', $res_id, $art, $text_id, $lang_trans_id);

#		$loop_data[$counter]{ROW_COLOR} = 'yellow';

	}elsif($art == 4){

		$loop_data[$counter]{TEXT_RES_MES}  =  $mgr->{Func}->get_text($mgr, 8040) . ' ' . "$lan_name";
		$loop_data[$counter]{TEXT_FUNC_DELETE} = $mgr->{Func}->get_text($mgr, 8033);
		$loop_data[$counter]{TEXT_MES_DELETE_LINKS} = $self->get_delete_link($mgr, 'delete_trans_res', $res_id, $art, $text_id, $lang_trans_id);

#		$loop_data[$counter]{ROW_COLOR} = 'pink';
	}elsif($art == 5){

		$loop_data[$counter]{TEXT_RES_MES}  =  $mgr->{Func}->get_text($mgr, 8041) . ' ' . "$lan_name";
		$loop_data[$counter]{TEXT_FUNC_DELETE} = $mgr->{Func}->get_text($mgr, 8033);
		$loop_data[$counter]{TEXT_MES_DELETE_LINKS} = $self->get_delete_link($mgr, 'delete_trans_res', $res_id, $art, $text_id, $lang_trans_id);

#		$loop_data[$counter]{ROW_COLOR} = 'snow';
	}

$counter ++;
  }


$dbh->do("UNLOCK TABLES");
$sth->finish();

if ($counter == 0) {
	$mgr->{TmplData}{NO_MESSAGE_008023}  = $mgr->{Func}->get_text($mgr, 8023);
}else{

$mgr->{TmplData}{TEXT_USER_LOOP_MES} = \@loop_data;
$mgr->{TmplData}{PAGE_LANG_008022} = $mgr->{Func}->get_text($mgr, 8022);
$mgr->{TmplData}{PAGE_LANG_008019} = $mgr->{Func}->get_text($mgr, 8019);
$mgr->{TmplData}{PAGE_LANG_008020} = $mgr->{Func}->get_text($mgr, 8020);


}

$mgr->{TmplData}{PAGE_TITLE}  = $mgr->{Func}->get_text($mgr, 8021);
$mgr->{Template} = $mgr->{TmplFiles}->{Text_User_Mes};
$mgr->{TmplData}{PAGE_METHOD} = 'text_message_user';




}



sub get_delete_link {
  my ($self, $mgr, $method, $res_id, $res_art, $text_id, $lang_trans_id) = @_;

  my $link = sprintf("%s?action=%s&lang=%s&sid=%s&method=%s&res_id=%s&art=%s&text_id=%s&trans_lang=%s",
			$mgr->{ScriptName},
			$mgr->{Action},
			$mgr->{SystemLangs}->{$mgr->{Language}},
			$mgr->{SessionId}, 
			$method, 
			$res_id,
			$res_art, $text_id, $lang_trans_id );

  return $link;
}


sub get_upload_link{
my ($self, $mgr, $method, $res_id, $text_id, $lang_trans_id) = @_;

  my $link = sprintf("%s?action=%s&lang=%s&sid=%s&method=%s&res_id=%s&text_id=%s&trans_lang=%s",
			$mgr->{ScriptName},
			$mgr->{Action},
			$mgr->{SystemLangs}->{$mgr->{Language}},
			$mgr->{SessionId}, 
			$method, 
			$res_id,
			$text_id,
			$lang_trans_id);

  return $link;


}

sub text_to_trans_download{
my ($self, $mgr) = @_;

my $text_id = $mgr->{CGI}->param('text_to_trans_id') || undef;
my $trans_lang = $mgr->{CGI}->param('trans_lang') || undef;

my $submit_download  = $mgr->{CGI}->param('text_download') || undef;
my $submit_trans = $mgr->{CGI}->param('text_trans') || undef;

my $show_this_tmpl = 1;
my $set_url = 1;

if ($text_id){

	if ($submit_download){
		if ($trans_lang){
		my $lan_name = $mgr->{Func}->get_lang($mgr, $trans_lang);
		my @text_langs_check = $self->get_text_langs($mgr, $text_id);

			if (!(grep(/$trans_lang/, @text_langs_check))){ 				

				my $text_res_table;
				my $text_table;
				my $dbh;
				my $sth;
#-------------------------------------------------------------
				#search Autor_id in lingua_text
				my $search = 1;
				my $new_text_id = $text_id;
				my ($actual_text_id, $parent_id, $autor_id);

				$text_table = $mgr->{Tables}->{TEXT};
				$dbh = $mgr->connect();			

				while ($search == 1){

$sth = $dbh->prepare(<<SQL);

SELECT text_id, parent_id, user_id
FROM   $text_table
WHERE  text_id = ?

SQL

unless ($sth->execute($new_text_id)) {
	warn sprintf("[Error:] Trouble selecting data from [%s].".
	         "Reason: [%s].", $text_table, $dbh->errstr());
    	$mgr->fatal_error("Database error.");
}

($actual_text_id, $parent_id, $autor_id) = $sth->fetchrow_array();

if ($parent_id == 0){	
	$search = 0;
}else{
	$new_text_id =  $parent_id;
}
} #End while




#-------------------------------------------------------------
				#Mot au Übersetzer
				my $translator_user_id = $mgr->{UserData}->{UserId} || undef;
				$text_res_table = $mgr->{Tables}->{TEXT_RES};

				unless ( $dbh->do("LOCK TABLES $text_res_table WRITE"))
				{
					warn sprintf("[Error]: Trouble locking tables %s" .
					"Reason: [%s].",  $text_res_table, $dbh->errstr());
					$dbh->do("UNLOCK TABLES");
					$mgr->fatal_error("Database error.");
				}

$sth = $dbh->prepare(<<SQL);

INSERT INTO $text_res_table (text_id, lang_trans_id, user_id, art) 
VALUES (?, ?, ?, ?)

SQL

unless ($sth->execute($text_id, $trans_lang, $translator_user_id, '2')) {
	warn sprintf("[Error:] Trouble insert data in [%s].".
	         "Reason: [%s].", $text_res_table, $dbh->errstr());
    	$mgr->fatal_error("Database error.");
}

	
#-------------------------------------------------------------
			#Mot a Autor
$sth = $dbh->prepare(<<SQL);

INSERT INTO $text_res_table (text_id, lang_trans_id, user_id, art) 
VALUES (?, ?, ?, ?)

SQL

unless ($sth->execute($actual_text_id, $trans_lang, $autor_id, '3')) {
	warn sprintf("[Error:] Trouble insert data in [%s].".
	         "Reason: [%s].", $text_res_table, $dbh->errstr());
    	$mgr->fatal_error("Database error.");
}


$dbh->do("UNLOCK TABLES");
$sth->finish();

#----------
  my $method = 'download_text';
  my $link = sprintf("%s?action=%s&lang=%s&sid=%s&method=%s&text_id=%s",
			$mgr->{ScriptName},
			$mgr->{Action},
			$mgr->{SystemLangs}->{$mgr->{Language}},
			$mgr->{SessionId}, 
			$method, 
			$text_id);

				$mgr->{TmplData}{TEXT_DOWNLOAD} = $link;
				$mgr->{TmplData}{PAGE_LANG_008017}     = $mgr->{Func}->get_text($mgr, 8017);

				$mgr->{TmplData}{TEXT_BACK} =  'window.history.go(-2)';
				$set_url =0;

			#show this_tmpl with confirmation  & download tex
			$mgr->{TmplData}{TRANS_ERROR} =  $mgr->{Func}->get_text($mgr, 8042) . ' ' . "$lan_name";
	}else{
	#if val
			$mgr->{TmplData}{TEXT_LANGS_ERROR} = $mgr->{Func}->get_text($mgr, 8043) . ' ' . "$lan_name";

	}
		}else{		
		#trans_lang not defined
			$mgr->{TmplData}{TEXT_LANGS_ERROR} = $mgr->{Func}->get_text($mgr, 8044);
		}

	}elsif ($submit_trans){
	#submit_download
		$self->text_trans($mgr, "online_trans", $text_id, $trans_lang);
		$show_this_tmpl =0;	
	}

#}#text_id
	if ($show_this_tmpl == 1){
		my @langs      = $mgr->{Func}->get_langs($mgr);
		my @text_langs =   $self->get_text_langs($mgr, $text_id);
		my @langs_array;
		my $lang;
			
		foreach $lang (@langs) {

			if  (!(grep(/$lang->[0]/, @text_langs))){
				push(@langs_array, $lang);
			}
		}
	
		my $lang_count = 0;
		my @lang_result;

		foreach my $lang (@langs_array) {

			if ((defined $trans_lang) and ($lang->[0] == $trans_lang)){
				$mgr->{TmplData}{TEXT_TRANS_LANG_IF} = 1;
			}

			$lang_result[$lang_count]{TEXT_TRANS_LANG_ID}         = $lang->[0];
	    		$lang_result[$lang_count]{TEXT_TRANS_LANG_NAME}       = $lang->[1];
	
			$lang_count++;
		}

		@lang_result = sort {$a->{TEXT_TRANS_LANG_NAME} cmp $b->{TEXT_TRANS_LANG_NAME}} @lang_result;

		$mgr->{TmplData}{TEXT_ID} = $text_id;
		$mgr->{TmplData}{LOOP_TEXT_TRANS_LANG} = \@lang_result;
		$mgr->{TmplData}{PAGE_METHOD} = 'text_to_trans_download';
	if ($set_url == 1){
	  $mgr->{TmplData}{TEXT_BACK}            =  $self->get_javascript_url_back();
	}
	  $mgr->{TmplData}{PAGE_LANG_007001}     = $mgr->{Func}->get_text($mgr, 7001);
	  $mgr->{TmplData}{PAGE_LANG_007017}     = $mgr->{Func}->get_text($mgr, 7017);
	  $mgr->{TmplData}{PAGE_LANG_008018}     = $mgr->{Func}->get_text($mgr, 8018);
	  $mgr->{TmplData}{PAGE_LANG_008016}     = $mgr->{Func}->get_text($mgr, 8016);

		
		$mgr->{Template} = $mgr->{TmplFiles}->{Text_Trans_Download};

	}

}else{
	$mgr->{Template} = $mgr->{TmplFiles}->{Error};
}


}



sub download_text{

my ($self, $mgr) = @_;

my $text_id = $mgr->{CGI}->param('text_id') || undef;

if ($text_id){
#select text, header, desc to download
my $text_table = $mgr->{Tables}->{TEXT};
my $dbh        = $mgr->connect();			

my $sth        = $dbh->prepare(<<SQL);

SELECT text_header, text_desc, text_content
FROM   $text_table
WHERE  text_id = ?

SQL

unless ($sth->execute($text_id)) {
	warn sprintf("[Error:] Trouble selecting data from [%s].".
		"Reason: [%s].", $text_table, $dbh->errstr());
		$mgr->fatal_error("Database error.");
}

my ($text_header, $text_desc, $text_content) = $sth->fetchrow_array();

$dbh->do("UNLOCK TABLES");
$sth->finish();
		$mgr->{TmplData}{PAGE_CHARSET}= $mgr->{Charset};
		$mgr->{TmplData}{CLOSE_WIN} =  $mgr->{Func}->get_text($mgr, 8045);

		$mgr->{TmplData}{TEXT_DOWNLOAD_INFO} =  $mgr->{Func}->get_text($mgr, 8046);
		$mgr->{TmplData}{TEXT_HEADER} = $mgr->escape($text_header);
		$mgr->{TmplData}{TEXT_DESC} = $mgr->escape($text_desc);
		$mgr->{TmplData}{TEXT_TEXT} = $mgr->escape($text_content);
		$mgr->{Template} = $mgr->{TmplFiles}->{Text_Download};



}else{
#schreib error

}

}

#-----------------------------------------------------------------------------#
#CALL: $self->show_text_see($mgr)                                             #
#                                                                             #
#RETURN:                                                                      #
#                                                                             #
#DESC: See SQL Statement                                                      #
#                                                                             #
#Author: Hendrik Erler(erler@cs.tu-berlin.de)                                 #
#-----------------------------------------------------------------------------#

sub show_text_see {
  my ($self, $mgr) = @_;
  my $text_id = $mgr->{CGI}->param('text_id') || undef;
  my $text_rating = $mgr->{CGI}->param('text_rating') || undef;

  $mgr->{Template} = $mgr->{TmplFiles}->{Text_Show};

  if (defined $text_id){
    $self->show_text($mgr);
  }
}



#-----------------------------------------------------------------------------#
#CALL: $self->show_text_original($mgr)                                        #
#                                                                             #
#RETURN:                                                                      #
#                                                                             #
#DESC: See SQL Statement                                                      #
#                                                                             #
#Author: Hendrik Erler(erler@cs.tu-berlin.de)                                 #
#-----------------------------------------------------------------------------#
sub show_text{
  my ($self, $mgr) = @_;
  my $given_text_id = $mgr->{CGI}->param('text_id') || undef;
  my $current_user_id = $mgr->{Session}->get('UserId');
  my $current_user_level = $mgr->{Session}->get('UserLevel');

#if selected another language in language-Box
  if ($mgr->{CGI}->param('method') eq 'view_trans' || defined $mgr->{CGI}->param('view_trans')){
    $given_text_id = $mgr->{CGI}->param('text_trans_lang_id') || undef;
  }
  $mgr->{TmplData}{TEXT_ID} = $given_text_id;

#get Textvalues from text-Table #############
  my $table = $mgr->{Tables}->{TEXT};

  my $dbh = $mgr->connect();
  my $sth = $dbh->prepare(<<SQL);

SELECT  text_id, parent_id, text_header, text_desc, text_content, num_words,
        lang_id, submit_time, user_id, category_id, status, avg_rating, num_ratings,
        lang_trans_id
FROM   $table
WHERE  text_id = ?

SQL

  unless ($sth->execute($given_text_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }

  my @row = $sth->fetchrow_array();
  my $text_id       = $row[0];
  my $parent_id     = $row[1];
  my $text_header   = $row[2];
  my $text_desc     = $row[3];
  my $text_content  = $row[4];
  my $num_words     = $row[5];
  my $lang_id       = $row[6];
  my $submit_time   = $row[7];
  my $user_id       = $row[8];
  my $category_id   = $row[9];
  my $status        = $row[10];
  my $avg_rating    = $row[11];
  my $num_ratings   = $row[12];
  my $lang_trans_id = $row[13];

  $sth->finish();

  # fill template lingua_show_text.tmpl
  #$mgr->{TmplData}{PAGE_LANG_007023} = $mgr->{Func}->get_text($mgr, 7023);#Title
  $mgr->{TmplData}{PAGE_LANG_007120} = $mgr->{Func}->get_text($mgr, 7120);#Title of Text
  $mgr->{TmplData}{PAGE_LANG_007124} = $mgr->{Func}->get_text($mgr, 7124);#Language of Text
  $mgr->{TmplData}{PAGE_LANG_007122} = $mgr->{Func}->get_text($mgr, 7122);#Text-Description
  $mgr->{TmplData}{PAGE_LANG_007121} = $mgr->{Func}->get_text($mgr, 7121);#Text_Length
  $mgr->{TmplData}{PAGE_LANG_007102} = $mgr->{Func}->get_text($mgr, 7102);#TEXT_ORIG_LANG
  $mgr->{TmplData}{PAGE_LANG_007103} = $mgr->{Func}->get_text($mgr, 7103);#TEXT_TRANS_LANGUAGES
  $mgr->{TmplData}{PAGE_LANG_007125} = $mgr->{Func}->get_text($mgr, 7125);#TEXT_RATING_NUMBER
  $mgr->{TmplData}{PAGE_LANG_007105} = $mgr->{Func}->get_text($mgr, 7105);#TEXT_RATING_NUMBER
  $mgr->{TmplData}{PAGE_LANG_007101} = $mgr->{Func}->get_text($mgr, 7101);#TEXT
  $mgr->{TmplData}{PAGE_LANG_007106} = $mgr->{Func}->get_text($mgr, 7106);#text_trans_button
  $mgr->{TmplData}{PAGE_LANG_007114} = $mgr->{Func}->get_text($mgr, 7114);#delete_text_button
  $mgr->{TmplData}{PAGE_LANG_007116} = $mgr->{Func}->get_text($mgr, 7116);#TEXT_SUBMIT_TIME
  $mgr->{TmplData}{PAGE_LANG_007123} = $mgr->{Func}->get_text($mgr, 7123);#TEXT_CAT
  $mgr->{TmplData}{PAGE_LANG_007118} = $mgr->{Func}->get_text($mgr, 7118);#View_Translation_Button
  $mgr->{TmplData}{PAGE_LANG_007119} = $mgr->{Func}->get_text($mgr, 7119);#Titel of Page
  $mgr->{TmplData}{TEXT_TITLE} = $mgr->escape($text_header);
  $mgr->{TmplData}{TEXT_LANGUAGE} = $self->lang_name($mgr, $lang_id);
  $mgr->{TmplData}{TEXT_DESCRIPTION} = $mgr->escape($text_desc);
  $mgr->{TmplData}{TEXT_LENGTH} = $num_words;
  $mgr->{TmplData}{TEXT} = $mgr->escape($text_content);
  $mgr->{TmplData}{PARENT_ID} = $parent_id;



#User-handlig for Delete-Button and Transalation-Button
  if(!(defined $mgr->{UserData}->{UserId})){
    $mgr->{TmplData}{SUBMIT_DELETE_TYPE} = 'hidden';
    $mgr->{TmplData}{SUBMIT_TRANS_TYPE} = 'hidden';
  }elsif($current_user_level == 0){
    $mgr->{TmplData}{SUBMIT_DELETE_TYPE} = 'hidden';
    $mgr->{TmplData}{SUBMIT_TRANS_TYPE} = 'submit';
    $mgr->{TmplData}{TEXT_TO_TRANS_DOWNLOAD} = 'text_to_trans_download';
  }elsif($current_user_level > 0){
    $mgr->{TmplData}{SUBMIT_DELETE_TYPE} = 'submit';
    $mgr->{TmplData}{SUBMIT_TRANS_TYPE} = 'submit';
    $mgr->{TmplData}{TEXT_TO_TRANS_DOWNLOAD} = 'text_to_trans_download';
    $mgr->{TmplData}{DELETE_TEXT} = 'delete_text';
  }

#test wether current user rated this text#############
  $table = $mgr->{Tables}->{TEXT_RATING};
  $dbh = $mgr->connect();
  $sth = $dbh->prepare(<<SQL);

SELECT  user_id, text_id, text_rating
FROM   $table
WHERE  user_id = ? AND text_id = ?

SQL

  unless ($sth->execute($current_user_id, $given_text_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }

  @row = $sth->fetchrow_array();
  my $text_rating_id  = $row[1];
  my $text_rating     = $row[2];

  $sth->finish();

  #$mgr->{TmplData}{PAGE_LANG_002104} = $mgr->{Func}->get_text($mgr, 2112);#TEXT_RATING Average
  #$mgr->{TmplData}{PAGE_LANG_002112} = $mgr->{Func}->get_text($mgr, 2112);#TEXT_RATING

#Original Language of this Text##################
  my $orig_text_id = $self->get_original_text($mgr, $text_id);

  $table = $mgr->{Tables}->{TEXT};
  $dbh = $mgr->connect();
  $sth = $dbh->prepare(<<SQL);
SELECT lang_id
FROM   $table
WHERE  text_id = ?

SQL
  unless ($sth->execute($orig_text_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }
  @row = $sth->fetchrow_array();
  my $orig_lang_id = $row[0];
  $sth->finish();
  $mgr->{TmplData}{TEXT_ORIG_LANG} = $self->lang_name($mgr,$orig_lang_id);


#Translated Languages of this Text##################
  my @lang_loop_data;
  @lang_loop_data = $self->get_relation_texts($mgr, $orig_text_id, @lang_loop_data);
  my %data;
  $data{TEXT_TRANS_LANG_ID}= $orig_text_id;
  $data{TEXT_TRANS_LANG_NAME}= $self->lang_name($mgr,$orig_lang_id);
  push(@lang_loop_data,\%data);
  @lang_loop_data = sort {$self->sort_uml($a->{TEXT_TRANS_LANG_NAME},$b->{TEXT_TRANS_LANG_NAME})} @lang_loop_data;
  $mgr->{TmplData}{TEXT_LOOP_TRANS_LANG}=\@lang_loop_data;
  $mgr->{TmplData}{SUBMIT_VIEW_TRANS_TYPE}='submit';

#translation Request. Show only if an request exist and if not translated in the request language
  my $row;
  my $trans_request = 0;
  foreach $row (@lang_loop_data){
    if($row->{TEXT_TRANS_LANG_NAME} eq $mgr->{Func}->get_lang($mgr, $lang_trans_id)){
      $trans_request = 1;
    }
  }

  if($lang_trans_id > 0 && $trans_request == 0){
    $mgr->{TmplData}{TRANS_REQUEST} = $mgr->{Func}->get_lang($mgr, $lang_trans_id);
    $mgr->{TmplData}{PAGE_LANG_007126} =$mgr->{Func}->get_text($mgr, 7126);#Translation Request
  }

#fill category-name of this Text##################
  $mgr->{TmplData}{CAT_LINk} = $mgr->my_url(ACTION => "text", METHOD => "show_texts") . '&cat_id=' . $category_id;
  $mgr->{TmplData}{TEXT_CAT} = $mgr->{Func}->get_text($mgr, $self->cat_lang_id($mgr,$category_id));
  $mgr->{TmplData}{CAT_LANG_ID} = $self->cat_lang_id($mgr,$category_id);


#handle rate_view ###################################
  if($avg_rating < 1.5 && $avg_rating != 0){ $mgr->{TmplData}{TEXT_RATING} = $mgr->{Func}->get_text($mgr, 7111); }
  elsif($avg_rating < 2.5 && $avg_rating >= 1.5){ $mgr->{TmplData}{TEXT_RATING} = $mgr->{Func}->get_text($mgr, 7110); }
  elsif($avg_rating < 3.5 && $avg_rating >= 2.5){ $mgr->{TmplData}{TEXT_RATING} = $mgr->{Func}->get_text($mgr, 7109); }
  elsif($avg_rating < 4.5 && $avg_rating >= 3.5){ $mgr->{TmplData}{TEXT_RATING} = $mgr->{Func}->get_text($mgr, 7108); }
  elsif($avg_rating >= 4.5){ $mgr->{TmplData}{TEXT_RATING} = $mgr->{Func}->get_text($mgr, 7107); }
  $mgr->{TmplData}{TEXT_RATING_NUMBER} = $num_ratings;
  $mgr->{TmplData}{TEXT_SUBMIT_TIME} = substr($submit_time,6, 2) . "." . substr($submit_time,4, 2) . "." .substr($submit_time,0, 4);


#show text-rating-radio-buttons only if user not owner by this text and if user haven't rated this text
  if(!(defined $mgr->{UserData}->{UserId}) || $current_user_id == $user_id || $text_rating_id == $given_text_id) {
    $mgr->{TmplData}{RADIO_TYPE} = 'hidden';
    $mgr->{TmplData}{SUBMIT_TYPE} = 'hidden';

    if(defined $text_rating){
      if($text_rating == 1 ){$mgr->{TmplData}{PAGE_LANG_007112} = $mgr->{Func}->get_text($mgr, 7117) . " " . $mgr->{Func}->get_text($mgr, 7111); }
      elsif($text_rating == 2){$mgr->{TmplData}{PAGE_LANG_007112} = $mgr->{Func}->get_text($mgr, 7117) . " " . $mgr->{Func}->get_text($mgr, 7110);}
      elsif($text_rating == 3){$mgr->{TmplData}{PAGE_LANG_007112} = $mgr->{Func}->get_text($mgr, 7117) . " " . $mgr->{Func}->get_text($mgr, 7109);}
      elsif($text_rating == 4){$mgr->{TmplData}{PAGE_LANG_007112} = $mgr->{Func}->get_text($mgr, 7117) . " " . $mgr->{Func}->get_text($mgr, 7108); }
      elsif($text_rating == 5){ $mgr->{TmplData}{PAGE_LANG_007112} = $mgr->{Func}->get_text($mgr, 7117) . " " . $mgr->{Func}->get_text($mgr, 7107);}
    }  
  }
  else{
    $mgr->{TmplData}{PAGE_LANG_007107} = $mgr->{Func}->get_text($mgr, 7107);
    $mgr->{TmplData}{PAGE_LANG_007108} = $mgr->{Func}->get_text($mgr, 7108);
    $mgr->{TmplData}{PAGE_LANG_007109} = $mgr->{Func}->get_text($mgr, 7109);
    $mgr->{TmplData}{PAGE_LANG_007110} = $mgr->{Func}->get_text($mgr, 7110);
    $mgr->{TmplData}{PAGE_LANG_007111} = $mgr->{Func}->get_text($mgr, 7111);
    $mgr->{TmplData}{PAGE_LANG_007113} = $mgr->{Func}->get_text($mgr, 7113);
    $mgr->{TmplData}{RADIO_TYPE} = 'radio';
    $mgr->{TmplData}{SUBMIT_TYPE} = 'submit';
    $mgr->{TmplData}{RATE_TEXT} = 'text_rating';
  }

#Author of this Text#####################
  if($user_id ne $current_user_id && defined $mgr->{UserData}->{UserId}){
    $mgr->{TmplData}{PAGE_LANG_007100} = $mgr->{Func}->get_text($mgr, 7100);#Author
    $mgr->{TmplData}{AUTHOR_LINK} = $mgr->my_url(ACTION => "user", METHOD => "otherspage") . '&user_id=' . $user_id;
    $mgr->{TmplData}{TEXT_AUTOR} = $self->get_author($mgr, $user_id);
  }
  $mgr->{TmplData}{AUTHOR_ID} =$user_id ;
}#end show_text

#-----------------------------------------------------------------------------#
#CALL: $self->get_original_text($mgr, text_id)                                #
#                                                                             #
#RETURN:                                                                      #
#                                                                             #
#DESC: rekursiv call to get the root original text                            #
#                                                                             #
#                                                                             #
#Author: Hendrik Erler(erler@cs.tu-berlin.de)                                 #
#-----------------------------------------------------------------------------#
sub decrement_category_entry{
  my ($self, $mgr, $text_id) = @_;

# get category_id of this text
  my $table = $mgr->{Tables}->{TEXT};
  my $dbh = $mgr->connect();
  $dbh->do("LOCK TABLES $table WRITE");
  my $sth = $dbh->prepare(<<SQL);
SELECT category_id
FROM   $table
WHERE  text_id = ?

SQL
  unless ($sth->execute($text_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
    $dbh->do("UNLOCK TABLES");
  }
  my @row = $sth->fetchrow_array();
  my $TEXT_category_id = $row[0];
  $dbh->do("UNLOCK TABLES");
  $sth->finish();


#get text_count from the category where this text is contain
  $table = $mgr->{Tables}->{CATS};
  $dbh = $mgr->connect();
  $dbh->do("LOCK TABLES $table WRITE");
  $sth = $dbh->prepare(<<SQL);
SELECT text_count
FROM   $table
WHERE  cat_id = ?

SQL
  unless ($sth->execute($TEXT_category_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
    $dbh->do("UNLOCK TABLES");
  }
  @row = $sth->fetchrow_array();
  my $CATS_text_count=$row[0];
  $dbh->do("UNLOCK TABLES");
  $sth->finish();

#decrement text_count and put the new value into Table CATS
  $CATS_text_count = $CATS_text_count - 1;

  $table = $mgr->{Tables}->{CATS};
  $dbh = $mgr->connect();
  $dbh->do("LOCK TABLES $table WRITE");
  $sth = $dbh->prepare(<<SQL);
UPDATE LOW_PRIORITY $table SET text_count=?
WHERE cat_id= ?

SQL

    unless ($sth->execute($CATS_text_count, $TEXT_category_id))
    {
	  warn sprintf("[Error:] Trouble adding user to %s. " .
	  	     "Reason: [%s].", $table, $dbh->errstr());
	  $dbh->do("UNLOCK TABLES");
	  $mgr->fatal_error("Database error.");
	  $dbh->do("UNLOCK TABLES");
    }

    $dbh->do("UNLOCK TABLES");
    $sth->finish();

}#end decrement_category_entry

#-----------------------------------------------------------------------------#
#CALL: $self->get_original_text($mgr, text_id)                                #
#                                                                             #
#RETURN: @text_id;                                                            #
#                                                                             #
#DESC: rekursiv call to get the root original text                            #
#                                                                             #
#                                                                             #
#Author: Hendrik Erler(erler@cs.tu-berlin.de)                                 #
#-----------------------------------------------------------------------------#
sub get_original_text{
  my ($self, $mgr, $text_id) = @_;
  my $table = $mgr->{Tables}->{TEXT};
  my $dbh = $mgr->connect();
  my $sth = $dbh->prepare(<<SQL);
SELECT parent_id, text_id
FROM   $table
WHERE  text_id = ?

SQL
  unless ($sth->execute($text_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }
  my @row = $sth->fetchrow_array();

  $sth->finish();
  if($row[0] > 0){
    $text_id = $self->get_original_text($mgr, $row[0]);
  }
  return $text_id;
}#end get_original_text

#-----------------------------------------------------------------------------#
#CALL: $self->get_relation_texts($mgr, $text_id)                              #
#                                                                             #
#RETURN: @lang_loop_data;                                                     #
#                                                                             #
#DESC: rekursiv call to get all relation texts, because translation of        #
#      translation                                                            #
#                                                                             #
#Author: Hendrik Erler(erler@cs.tu-berlin.de)                                 #
#-----------------------------------------------------------------------------#
sub get_relation_texts{
  my ($self, $mgr, $text_id, @lang_loop_data) = @_;

#Translated Languages of this Text##################
  my $table = $mgr->{Tables}->{TEXT};
  my $dbh = $mgr->connect();
  my $sth = $dbh->prepare(<<SQL);
SELECT text_id, parent_id, lang_id
FROM   $table
WHERE  parent_id = ?

SQL
  unless ($sth->execute($text_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }
  $table = $sth->fetchall_arrayref();
  my $row;
  foreach $row (@$table){
    my %data;
    $data{TEXT_TRANS_LANG_ID}= $row->[0];
    $data{TEXT_TRANS_LANG_NAME}= $self->lang_name($mgr,$row->[2]);
    push(@lang_loop_data,\%data);
    if(defined $row->[0]){
      @lang_loop_data = $self->get_relation_texts($mgr, $row->[0], @lang_loop_data);
    }
  }
  $sth->finish();
  return @lang_loop_data;
}#end get_relation_texts



#-----------------------------------------------------------------------------#
#CALL: $self->cat_lang_id($mgr)                                               #
#                                                                             #
#RETURN: $firstname . " " . $lastname;                                        #
#                                                                             #
#DESC: See SQL Statement                                                      #
#                                                                             #
#Author: Hendrik Erler(erler@cs.tu-berlin.de)                                 #
#-----------------------------------------------------------------------------#
sub get_author{
  my ($self, $mgr, $user_id) = @_;
#Author of this Text#####################
  my $table = $mgr->{Tables}->{USER};
  my $dbh = $mgr->connect();
  my $sth = $dbh->prepare(<<SQL);
SELECT user_id, lastname, firstname
FROM   $table
WHERE  user_id = ?

SQL
  unless ($sth->execute($user_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }
  my @row = $sth->fetchrow_array();
  $sth->finish();
  my $lastname  = $row[1];
  my $firstname = $row[2];
  return $firstname . " " . $lastname;
}#end get_author


#-----------------------------------------------------------------------------#
#CALL: $self->cat_lang_id($mgr)                                               #
#                                                                             #
#RETURN: cat_lang_id                                                          #
#                                                                             #
#DESC: See SQL Statement                                                      #
#                                                                             #
#Author: Hendrik Erler(erler@cs.tu-berlin.de)                                 #
#-----------------------------------------------------------------------------#
sub cat_lang_id{
  my ($self, $mgr, $category_id) = @_;

#Category-Name of this Text##################
  my $table = $mgr->{Tables}->{CATS};
  my $dbh = $mgr->connect();
  my $sth = $dbh->prepare(<<SQL);
SELECT cat_id, lang_id
FROM   $table
WHERE  cat_id = ?

SQL
  unless ($sth->execute($category_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }
  my @row = $sth->fetchrow_array();
  my $cat_lang_id  = $row[1];
  $sth->finish();

  return $cat_lang_id;
}#end cat_lang_id


#-----------------------------------------------------------------------------#
#CALL: $self->texts_own($mgr)                                                 #
#                                                                             #
#RETURN:                                                                      #
#                                                                             #
#DESC: See SQL Statement                                                      #
#                                                                             #
#Author: Hendrik Erler(erler@cs.tu-berlin.de)                                 #
#-----------------------------------------------------------------------------#
sub texts_own{
  my ($self, $mgr) = @_;

  # by Sören,  Änderungen wegen Zugriffe noch. UserID muss über Parameter gelesen werden.
  my $user_id = $mgr->{CGI}->param('user_id');  #$mgr->{UserData}->{UserId};
  $mgr->{Template} = $mgr->{TmplFiles}->{Texts_Own};
  #$mgr->{TmplData}{USERID} = $user_id;

# fill Titel of texts-table
    $mgr->{TmplData}{PAGE_LANG_007400} = $mgr->{Func}->get_text($mgr, 7400);
    $mgr->{TmplData}{PAGE_LANG_007401} = $mgr->{Func}->get_text($mgr, 7401);
    $mgr->{TmplData}{PAGE_LANG_007402} = $mgr->{Func}->get_text($mgr, 7402);
    $mgr->{TmplData}{PAGE_LANG_007403} = $mgr->{Func}->get_text($mgr, 7403);
    $mgr->{TmplData}{PAGE_LANG_007404} = $mgr->{Func}->get_text($mgr, 7404);
    $mgr->{TmplData}{USER} = $self->get_author($mgr, $user_id);

#get all original-texts from this user from table TEXT
  my $table = $mgr->{Tables}->{TEXT};
  my $dbh = $mgr->connect();
  my $sth = $dbh->prepare(<<SQL);
SELECT  user_id, text_id, text_header, lang_id, category_id, submit_time
FROM   $table
WHERE  user_id = ? AND parent_id = ?

SQL

  unless ($sth->execute($user_id, 0)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }
  my $rowtable = $sth->fetchall_arrayref();
  $sth->finish();
  my @text_loop_data;
  my $row;
  my @row;
  foreach $row(@$rowtable){
    my %data;
    #$data{TEXT_ID}= $row->[1];
    $data{TEXT_LINK}= $mgr->my_url(ACTION => "text", METHOD => "text_show") . '&text_id=' . $row->[1];
    $data{TEXT_HEADER}= $mgr->escape($row->[2]);
    $data{TEXT_LANG}= $self->lang_name($mgr,$row->[3]);
    $data{TEXT_CAT}= $mgr->{Func}->get_text($mgr, $self->cat_lang_id($mgr,$row->[4]));
    $data{TEXT_TIME}= substr($row->[5],6, 2) . "." . substr($row->[5],4, 2) . "." .substr($row->[5],0, 4);
    push(@text_loop_data,\%data);
  }
  #@text_loop_data = sort {$self->sort_uml($a->{TEXT_ID},$b->{TEXT_ID})} @text_loop_data;
  $mgr->{TmplData}{TEXT_LOOP}=\@text_loop_data;
}#end tests_own


#-----------------------------------------------------------------------------#
#CALL: $self->trans_own($mgr)                                                 #
#                                                                             #
#RETURN:                                                                      #
#                                                                             #
#DESC: See SQL Statement                                                      #
#                                                                             #
#Author: Hendrik Erler(erler@cs.tu-berlin.de)                                 #
#-----------------------------------------------------------------------------#
sub trans_own{
  my ($self, $mgr) = @_;
  my $user_id = $mgr->{UserData}->{UserId};
  $mgr->{Template} = $mgr->{TmplFiles}->{Trans_Own};
  #$mgr->{TmplData}{USERID} = $user_id;

# fill Titel of texts-table
    $mgr->{TmplData}{PAGE_LANG_007400} = $mgr->{Func}->get_text($mgr, 7400);
    $mgr->{TmplData}{PAGE_LANG_007401} = $mgr->{Func}->get_text($mgr, 7401);
    $mgr->{TmplData}{PAGE_LANG_007402} = $mgr->{Func}->get_text($mgr, 7402);
    $mgr->{TmplData}{PAGE_LANG_007403} = $mgr->{Func}->get_text($mgr, 7403);
    $mgr->{TmplData}{PAGE_LANG_007404} = $mgr->{Func}->get_text($mgr, 7405);
    $mgr->{TmplData}{USER} = $self->get_author($mgr, $user_id);

#get all original-texts from this user from table TEXT
  my $table = $mgr->{Tables}->{TEXT};
  my $dbh = $mgr->connect();
  my $sth = $dbh->prepare(<<SQL);
SELECT  user_id, text_id, text_header, lang_id, category_id, submit_time
FROM   $table
WHERE  user_id = ? AND parent_id > ?

SQL

  unless ($sth->execute($user_id, 0)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }
  my $rowtable = $sth->fetchall_arrayref();
  $sth->finish();
  my @text_loop_data;
  my $row;
  my @row;
  foreach $row(@$rowtable){
    my %data;
    #$data{TEXT_ID}= $row->[1];
    $data{TEXT_LINK}= $mgr->my_url(ACTION => "text", METHOD => "text_show") . '&text_id=' . $row->[1];
    $data{TEXT_HEADER}= $mgr->escape($row->[2]);
    $data{TEXT_LANG}= $self->lang_name($mgr,$row->[3]);
    $data{TEXT_CAT}= $mgr->{Func}->get_text($mgr, $self->cat_lang_id($mgr,$row->[4]));
    $data{TEXT_TIME}= substr($row->[5],6, 2) . "." . substr($row->[5],4, 2) . "." .substr($row->[5],0, 4);
    push(@text_loop_data,\%data);
  }
  #@text_loop_data = sort {$self->sort_uml($a->{TEXT_ID},$b->{TEXT_ID})} @text_loop_data;
  $mgr->{TmplData}{TEXT_LOOP}=\@text_loop_data;
}#end trans_own


#-----------------------------------------------------------------------------#
#CALL: $self->show_rating($mgr)                                               #
#                                                                             #
#RETURN:                                                                      #
#                                                                             #
#DESC: See SQL Statement                                                      #
#                                                                             #
#Author: Hendrik Erler(erler@cs.tu-berlin.de)                                 #
#-----------------------------------------------------------------------------#
sub text_rating {
  my ($self, $mgr) = @_;
  my $rating = $mgr->{CGI}->param('rating') || undef;
  my $user_id =$mgr->{Session}->get("UserId");
  my $text_id = $mgr->{CGI}->param('text_id') || undef;
  my $current_user_level = $mgr->{Session}->get('UserLevel');

#test wether current user rated this text#############
  my $table = $mgr->{Tables}->{TEXT_RATING};

  my $dbh = $mgr->connect();
  my $sth = $dbh->prepare(<<SQL);

SELECT  user_id, text_id, text_rating
FROM   $table
WHERE  user_id = ? AND text_id = ?

SQL

  unless ($sth->execute($user_id, $text_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }

  my @row = $sth->fetchrow_array();
  my $TEXT_RATING_user_id       = $row[0];
  my $TEXT_RATING_text_id       = $row[1];
  my $TEXT_RATING_text_rating   = $row[2];

  $sth->finish();

#if user not rated this text and selected an ratingvalue then insert this rating
#and if the userlevel of this user 1 or 2
  if(defined $rating && !(defined $TEXT_RATING_text_id) && defined $mgr->{UserData}->{UserId}){


    $table = $mgr->{Tables}->{TEXT};
    $dbh = $mgr->connect();
    $sth = $dbh->prepare(<<SQL);

SELECT  text_id, user_id, avg_rating, num_ratings
FROM   $table
WHERE  text_id = ?

SQL

    unless ($sth->execute($text_id)) {
      warn sprintf("[Error:] Trouble selecting data from [%s].".
                   "Reason: [%s].", $table, $dbh->errstr());
      $mgr->fatal_error("Database error.");
    }

    my @row = $sth->fetchrow_array();
    my $TEXT_text_id       = $row[0];
    my $TEXT_user_id       = $row[1];
    my $TEXT_avg_rating    = $row[2];
    my $TEXT_num_ratings   = $row[3];

    $sth->finish();



# insert rating-values in Table TEXT_RATNG #######

    $table = $mgr->{Tables}->{TEXT_RATING};
    $dbh = $mgr->connect();
    $dbh->do("LOCK TABLES $table WRITE");
    $sth = $dbh->prepare(<<SQL);


INSERT INTO $table (user_id, text_id, text_rating)
VALUES (?, ?, ?)

SQL

    unless ($sth->execute($user_id, $text_id, $rating))
    {
	  warn sprintf("[Error:] Trouble adding user to %s. " .
	  	       "Reason: [%s].", $table, $dbh->errstr());
	  $dbh->do("UNLOCK TABLES");
	  $mgr->fatal_error("Database error.");
    }

    $dbh->do("UNLOCK TABLES");

    $sth->finish();


# caculate new vaues for average_rating and num_ratings ####################
    if( $TEXT_avg_rating == 0){
      $TEXT_avg_rating = $rating;
    }
    else{
      $TEXT_avg_rating = (($TEXT_avg_rating * $TEXT_num_ratings) + $rating) / ($TEXT_num_ratings+1);
    }
    $TEXT_num_ratings += 1;


# insert new values for avg_rating and num_ratings into Table Text #############
    $table = $mgr->{Tables}->{TEXT};
    $dbh = $mgr->connect();
    $dbh->do("LOCK TABLES $table WRITE");
    $sth = $dbh->prepare(<<SQL);

UPDATE LOW_PRIORITY $table SET avg_rating=?, num_ratings=?
WHERE text_id= ?

SQL

    unless ($sth->execute($TEXT_avg_rating, $TEXT_num_ratings, $text_id))
    {
	  warn sprintf("[Error:] Trouble adding user to %s. " .
	  	     "Reason: [%s].", $table, $dbh->errstr());
	  $dbh->do("UNLOCK TABLES");
	  $mgr->fatal_error("Database error.");
    }

    $dbh->do("UNLOCK TABLES");
    $sth->finish();

  }#end if

  $self->show_text_see($mgr);

}#end text_rating



#-----------------------------------------------------------------------------#
#CALL: $self->delete_text($mgr)                                               #
#                                                                             #
#RETURN:                                                                      #
#                                                                             #
#DESC: See SQL Statement                                                      #
#                                                                             #
#Author: Hendrik Erler(erler@cs.tu-berlin.de)                                 #
#-----------------------------------------------------------------------------#
sub delete_text {
  my ($self, $mgr) = @_;

  my $text_id = $mgr->{CGI}->param('text_id') || undef;
  my $parent_id = $mgr->{CGI}->param('parent_id') || undef;

  my $delete_trans = $mgr->{CGI}->param('delete_trans') || undef;
  my $delete_all_orig = $mgr->{CGI}->param('delete_all_orig') || undef;
  my $delete_all_trans = $mgr->{CGI}->param('delete_all_trans') || undef;
  my $dont_delete_orig = $mgr->{CGI}->param('dont_delete_orig') || undef;
  my $dont_delete_trans = $mgr->{CGI}->param('dont_delete_trans') || undef;

  my $delete_all_ok = $mgr->{CGI}->param('delete_all_ok') || undef;
  my $delete_trans_ok = $mgr->{CGI}->param('delete_trans_ok') || undef;

  my $delete_text = $mgr->{CGI}->param('delete_text') || undef;
  my $author_id = $mgr->{CGI}->param('author_id') || undef;
  my $cat_lang_id = $mgr->{CGI}->param('cat_lang_id') || undef;

  if(defined $delete_trans || defined $delete_trans_ok){$self->delete_trans($mgr);}#delete_trans($mgr);}
  elsif(defined $delete_all_orig || defined $delete_all_trans || defined $delete_all_ok){$self->delete_all($mgr);}#delete_all($mgr);}
  elsif(defined $dont_delete_orig || defined $dont_delete_trans){$self->show_text_see($mgr);}#show_text_see($mgr);
  else
  {
    $mgr->{Template} = $mgr->{TmplFiles}->{Text_Delete};

    $mgr->{TmplData}{TEXT_ID} = $text_id ;#insert text_id in template as hidden
    $mgr->{TmplData}{PARENT_ID} = $parent_id ;#insert trans_text_id in template as hidden
    $mgr->{TmplData}{AUTHOR_ID} = $author_id ;#insert author_id in template as hidden
    $mgr->{TmplData}{CAT_LANG_ID} = $cat_lang_id ;#insert cat_lang_id_text_id in template as hidden

    $mgr->{TmplData}{PAGE_LANG_007214} = $mgr->{Func}->get_text($mgr, 7214);#delete_text Titel of this Page

    if($parent_id > 0){

      $mgr->{TmplData}{PAGE_LANG_007221} = $mgr->{Func}->get_text($mgr, 7221);#Original-text-information
      $mgr->{TmplData}{PAGE_LANG_007224} = $mgr->{Func}->get_text($mgr, 7224);#delete Translation
      $mgr->{TmplData}{PAGE_LANG_007225} = $mgr->{Func}->get_text($mgr, 7225);#delete all
      #$mgr->{TmplData}{PAGE_LANG_007228} = $mgr->{Func}->get_text($mgr, 7223);#don't delete
      $mgr->{TmplData}{PAGE_LANG_007226} = $mgr->{Func}->get_text($mgr, 7226);#delete translation Button
      $mgr->{TmplData}{PAGE_LANG_007227} = $mgr->{Func}->get_text($mgr, 7227);#delete all Button
      $mgr->{TmplData}{PAGE_LANG_007223} = $mgr->{Func}->get_text($mgr, 7223);#don't delete Button
      $mgr->{TmplData}{SUBMIT_ORIG_TYPE} = 'hidden';
      $mgr->{TmplData}{SUBMIT_TRANS_TYPE} = 'submit';

	}
    else{
      $mgr->{TmplData}{PAGE_LANG_007220} = $mgr->{Func}->get_text($mgr, 7220);#Original-text-information
      $mgr->{TmplData}{PAGE_LANG_007222} = $mgr->{Func}->get_text($mgr, 7222);#delete Button
      $mgr->{TmplData}{PAGE_LANG_007228} = $mgr->{Func}->get_text($mgr, 7223);#don't delete Button
      $mgr->{TmplData}{SUBMIT_ORIG_TYPE} = 'submit';
      $mgr->{TmplData}{SUBMIT_TRANS_TYPE} = 'hidden';

	}
    }
}#end delete_text

#-----------------------------------------------------------------------------#
#CALL: $self->delete_all($mgr)                                                #
#                                                                             #
#RETURN:                                                                      #
#                                                                             #
#DESC: See SQL Statement                                                      #
#                                                                             #
#Author: Hendrik Erler(erler@cs.tu-berlin.de)                                 #
#-----------------------------------------------------------------------------#
sub delete_all {
  my ($self, $mgr) = @_;
  my $text_id       = $mgr->{CGI}->param('text_id') || undef;
  my $author_id     = $mgr->{CGI}->param('author_id') || undef;
  my $cat_lang_id   = $mgr->{CGI}->param('cat_lang_id') || undef;

  my $text_orig_id = $self->get_original_text($mgr, $text_id);
  my @lang_loop_data;
  @lang_loop_data = $self->get_relation_texts($mgr, $text_orig_id, @lang_loop_data);

  my $row;

  my $table = $mgr->{Tables}->{TEXT};
  my $dbh = $mgr->connect();
  $dbh->do("LOCK TABLES $table WRITE");
  my $sth = $dbh->prepare(<<SQL);
SELECT category_id
FROM   $table
WHERE  text_id = ?

SQL
  unless ($sth->execute($text_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
    $dbh->do("UNLOCK TABLES");
  }
  my @row = $sth->fetchrow_array();
  my $TEXT_category_id = $row[0];
  $dbh->do("UNLOCK TABLES");
  $sth->finish();


# delete all translated texts
  foreach $row (@lang_loop_data){

#DELETE Translations of Original-Text##################
  $self->decrement_category_entry($mgr,$row->{TEXT_TRANS_LANG_ID});
  $table = $mgr->{Tables}->{TEXT};
  my $dbh = $mgr->connect();
  $dbh->do("LOCK TABLES $table WRITE");
  $sth = $dbh->prepare(<<SQL);
DELETE LOW_PRIORITY
FROM   $table
WHERE  text_id = ?

SQL
  unless ($sth->execute($row->{TEXT_TRANS_LANG_ID})) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $dbh->do("UNLOCK TABLES");
    $mgr->fatal_error("Database error.");
  }
  $dbh->do("UNLOCK TABLES");
  $sth->finish();
}#end foreach

#DELETE Original-Text##################
  $self->decrement_category_entry($mgr,$text_orig_id);
  $table = $mgr->{Tables}->{TEXT};
  $dbh = $mgr->connect();
  $dbh->do("LOCK TABLES $table WRITE");
  $sth = $dbh->prepare(<<SQL);
DELETE LOW_PRIORITY
FROM   $table
WHERE  text_id = ?

SQL
  unless ($sth->execute($text_orig_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $dbh->do("UNLOCK TABLES");
    $mgr->fatal_error("Database error.");
  }
  $sth->finish();


#DELETE Ratings of Original Text ##################
  $table = $mgr->{Tables}->{TEXT_RATING};
  $dbh = $mgr->connect();
  $dbh->do("LOCK TABLES $table WRITE");
  $sth = $dbh->prepare(<<SQL);
DELETE LOW_PRIORITY
FROM   $table
WHERE  text_id = ?

SQL
  unless ($sth->execute($text_orig_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $dbh->do("UNLOCK TABLES");
    $mgr->fatal_error("Database error.");
  }
  $dbh->do("UNLOCK TABLES");
  $sth->finish();



#DELETE Ratings of Translations ##################
  foreach $row (@lang_loop_data){

  my $table = $mgr->{Tables}->{TEXT_RATING};
  my $dbh = $mgr->connect();
  $dbh->do("LOCK TABLES $table WRITE");
  my $sth = $dbh->prepare(<<SQL);
DELETE LOW_PRIORITY
FROM   $table
WHERE  text_id = ?

SQL
  unless ($sth->execute($row->{TEXT_TRANS_LANG_ID})) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $dbh->do("UNLOCK TABLES");
    $mgr->fatal_error("Database error.");
  }
  $dbh->do("UNLOCK TABLES");
  $sth->finish();
}

#fill Template Text_Delete_Ok
  $author_id = $mgr->{CGI}->param('author_id') || undef;
  $cat_lang_id = $mgr->{CGI}->param('cat_lang_id') || undef;

  $mgr->{Template} = $mgr->{TmplFiles}->{Text_Delete_ALL_Ok};

  $mgr->{TmplData}{AUTHOR_ID} = $author_id ;#insert author_id in template as hidden
  $mgr->{TmplData}{CAT_LANG_ID} = $cat_lang_id ;#insert cat_lang_id_text_id in template as hidden

  $mgr->{TmplData}{PAGE_LANG_007300} = $mgr->{Func}->get_text($mgr, 7300);#text deleted-information
  $mgr->{TmplData}{PAGE_LANG_007301} = $mgr->{Func}->get_text($mgr, 7301);#Category of deleted Text
  $mgr->{TmplData}{PAGE_LANG_007302} = $mgr->{Func}->get_text($mgr, 7302);#Author of deleted Text

  $mgr->{TmplData}{CAT_LINk} = $mgr->my_url(ACTION => "text", METHOD => "show_texts") . '&cat_id=' . $TEXT_category_id;
  $mgr->{TmplData}{TEXT_CAT} = $mgr->{Func}->get_text($mgr, $cat_lang_id);


#Author of deleted Text#####################
  $table = $mgr->{Tables}->{USER};
  $dbh = $mgr->connect();
  $sth = $dbh->prepare(<<SQL);
SELECT user_id, lastname, firstname
FROM   $table
WHERE  user_id = ?

SQL
  unless ($sth->execute($author_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }
  @row = $sth->fetchrow_array();
  my $lastname  = $row[1];
  my $firstname = $row[2];
  $sth->finish();

  $mgr->{TmplData}{AUTHOR_LINK} = $mgr->my_url(ACTION => "user", METHOD => "otherspage") . '&user_id=' . $author_id;
  $mgr->{TmplData}{TEXT_AUTOR} = $firstname . " " . $lastname;

}#delete_all


#-----------------------------------------------------------------------------#
#CALL: $self->delete_trans($mgr)                                              #
#                                                                             #
#RETURN:                                                                      #
#                                                                             #
#DESC: See SQL Statement                                                      #
#                                                                             #
#Author: Hendrik Erler(erler@cs.tu-berlin.de)                                 #
#-----------------------------------------------------------------------------#
sub delete_trans {
  my ($self, $mgr) = @_;
  my $text_id       = $mgr->{CGI}->param('text_id') || undef;
  my $author_id     = $mgr->{CGI}->param('author_id') || undef;
  my $cat_lang_id   = $mgr->{CGI}->param('cat_lang_id') || undef;


#get parent_id , category_id, text_header of text which have to delete
  my $table = $mgr->{Tables}->{TEXT};
  my $dbh = $mgr->connect();
  $dbh->do("LOCK TABLES $table WRITE");
  my $sth = $dbh->prepare(<<SQL);
SELECT category_id, parent_id, text_header
FROM   $table
WHERE  text_id = ?

SQL
  unless ($sth->execute($text_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
    $dbh->do("UNLOCK TABLES");
  }
  my @row = $sth->fetchrow_array();
  my $TEXT_category_id = $row[0];
  my $TEXT_parent_id = $row[1] || undef;
  my $TEXT_text_header = $row[2];
  $dbh->do("UNLOCK TABLES");
  $sth->finish();


  if(!(defined $TEXT_parent_id)){
    $TEXT_parent_id = $mgr->{CGI}->param('parent_id') || undef;
    $TEXT_text_header = $mgr->{CGI}->param('text_title') || undef;
  }

#get childs of this text##############
  $table = $mgr->{Tables}->{TEXT};
  $dbh = $mgr->connect();
  $dbh->do("LOCK TABLES $table WRITE");
  $sth = $dbh->prepare(<<SQL);
SELECT text_id
FROM   $table
WHERE  parent_id = ?

SQL
  unless ($sth->execute($text_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
    $dbh->do("UNLOCK TABLES");
  }
  my $rowtable = $sth->fetchall_arrayref();
  $dbh->do("UNLOCK TABLES");
  $sth->finish();

#set new parent_id for childs
  #@row;
  my $row;
  foreach $row(@$rowtable){
    $self->set_parent_id($mgr, $row->[0], $TEXT_parent_id);
  }


#DELETE Translation##################
  $self->decrement_category_entry($mgr,$text_id);
  $table = $mgr->{Tables}->{TEXT};
  $dbh = $mgr->connect();
  $dbh->do("LOCK TABLES $table WRITE");
  $sth = $dbh->prepare(<<SQL);
DELETE LOW_PRIORITY
FROM   $table
WHERE  text_id = ?

SQL
  unless ($sth->execute($text_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $dbh->do("UNLOCK TABLES");
    $mgr->fatal_error("Database error.");
  }
  $dbh->do("UNLOCK TABLES");
  $sth->finish();



#DELETE Ratings of Translations snd Original-Text##################
  $table = $mgr->{Tables}->{TEXT_RATING};
  $dbh = $mgr->connect();
  $dbh->do("LOCK TABLES $table WRITE");
  $sth = $dbh->prepare(<<SQL);
DELETE LOW_PRIORITY
FROM   $table
WHERE  text_id = ?

SQL
  unless ($sth->execute($text_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $dbh->do("UNLOCK TABLES");
    $mgr->fatal_error("Database error.");
  }
  $dbh->do("UNLOCK TABLES");
  $sth->finish();

#fill Template Text_Delete_TRANS_Ok
  $author_id = $mgr->{CGI}->param('author_id') || undef;
  $cat_lang_id = $mgr->{CGI}->param('cat_lang_id') || undef;

  $mgr->{Template} = $mgr->{TmplFiles}->{Text_Delete_TRANS_Ok};
  $mgr->{TmplData}{AUTHOR_ID} = $author_id ;#insert author_id in template as hidden
  $mgr->{TmplData}{CAT_LANG_ID} = $cat_lang_id ;#insert cat_lang_id_text_id in template as hidden
  $mgr->{TmplData}{PARENT_ID} = $TEXT_parent_id;
  $mgr->{TmplData}{TEXT_TITLE} = $TEXT_text_header;

  $mgr->{TmplData}{PAGE_LANG_007300} = $mgr->{Func}->get_text($mgr, 7300);#text deleted-information
  $mgr->{TmplData}{PAGE_LANG_007301} = $mgr->{Func}->get_text($mgr, 7301);#Category of deleted Text
  $mgr->{TmplData}{PAGE_LANG_007302} = $mgr->{Func}->get_text($mgr, 7302);#Author of deleted Text
  $mgr->{TmplData}{PAGE_LANG_007305} = $mgr->{Func}->get_text($mgr, 7305);#Original text

  $mgr->{TmplData}{CAT_LINk} = $mgr->my_url(ACTION => "text", METHOD => "show_texts") . '&cat_id=' . $TEXT_category_id;
  $mgr->{TmplData}{TEXT_CAT} = $mgr->{Func}->get_text($mgr, $cat_lang_id);

  $mgr->{TmplData}{ORIGINAL_TEXT_LINK} = $mgr->my_url(ACTION => "text", METHOD => "text_show") . '&text_id=' . $TEXT_parent_id;
  $mgr->{TmplData}{ORIGINAL_TEXT_TITEL} = $mgr->escape($TEXT_text_header);

#Author of deleted Text#####################
  $table = $mgr->{Tables}->{USER};
  $dbh = $mgr->connect();
  $sth = $dbh->prepare(<<SQL);
SELECT user_id, username, lastname, firstname, email
FROM   $table
WHERE  user_id = ?

SQL
  unless ($sth->execute($author_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }
  @row = $sth->fetchrow_array();
  my $username  = $row[1];
  my $lastname  = $row[2];
  my $firstname = $row[3];
  my $email     = $row[4];
  $sth->finish();

  $mgr->{TmplData}{AUTHOR_LINK} = $mgr->my_url(ACTION => "user", METHOD => "otherspage") . '&user_id=' . $author_id;
  $mgr->{TmplData}{TEXT_AUTOR} = $firstname . " " . $lastname;

  #$self->show_text_see($mgr)

}#delete_trans

#-----------------------------------------------------------------------------#
#CALL: $self->set_parent_id($mgr,$text_id)                                    #
#                                                                             #
#RETURN:  lang_name correspond to lang_id                                     #
#                                                                             #
#DESC: 	Is called if presssed button for showing this Text in                 #
#	other Languages                                                       #
#                                                                             #
#Author: Hendrik Erler(erler@cs.tu-berlin.de)                                 #
#-----------------------------------------------------------------------------#
sub set_parent_id{
  my ($self, $mgr, $text_id, $parent_id) = @_;

  my $table = $mgr->{Tables}->{TEXT};
  my $dbh = $mgr->connect();
    $dbh->do("LOCK TABLES $table WRITE");
  my $sth = $dbh->prepare(<<SQL);

UPDATE LOW_PRIORITY $table SET parent_id = ?
WHERE text_id= ?

SQL

    unless ($sth->execute($parent_id, $text_id))
    {
	  warn sprintf("[Error:] Trouble adding user to %s. " .
	  	     "Reason: [%s].", $table, $dbh->errstr());
	  $dbh->do("UNLOCK TABLES");
	  $mgr->fatal_error("Database error.");
    }

    $dbh->do("UNLOCK TABLES");
    $sth->finish();

}#end lang_name


#-----------------------------------------------------------------------------#
#CALL: $self->lang_name($mgr,$lang_id)                                        #
#                                                                             #
#RETURN:  lang_name correspond to lang_id                                     #
#                                                                             #
#DESC: 	Is called if presssed button for showing this Text in                 #
#	other Languages                                                       #
#                                                                             #
#Author: Hendrik Erler(erler@cs.tu-berlin.de)                                 #
#-----------------------------------------------------------------------------#
sub lang_name{
  my ($self, $mgr, $lang_id) = @_;

  my $table = $mgr->{Tables}->{LANG};
  my $dbh = $mgr->connect();
  my $sth = $dbh->prepare(<<SQL);
SELECT lang_id, lang_name_id
FROM   $table
WHERE  lang_id = ?

SQL
  unless ($sth->execute($lang_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
                 "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }
  my @row = $sth->fetchrow_array();
  my $lang_name_id = $row[1];

  return $mgr->{Func}->get_text($mgr, $lang_name_id);

}#end lang_name

#-----------------------------------------------------------------------------#
#CALL: $self->sort_uml($self,$a,$b)                                           #
#                                                                             #
#RETURN:                                                                      #
#                                                                             #
#DESC: 	Is called if presssed button for showing this Text in                 #
#	other Languages                                                       #
#                                                                             #
#Author: Hendrik Erler(erler@cs.tu-berlin.de)                                 #
#-----------------------------------------------------------------------------#
sub sort_uml{
  my ($self, $a,$b) = @_;
  $_ = "\L" . $a;#->{TEXT_CAT_NAME};#change all characters to big characters
  tr/ÄÖÜäöü/AOUaou/;#change äöü to aou
  my $al = $_;
  $_ = "\L" . $b;#->{TEXT_CAT_NAME};#change all characters to big characters
  tr/ÄÖÜäöü/AOUaou/;#change äöü to aou
  my $bl = $_;

  return $al cmp $bl;
}

1;











