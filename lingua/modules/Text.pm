package modules::Text;

use Class::Singleton;
use base 'Class::Singleton';
use vars qw($VERSION);
use strict;

$VERSION = sprintf "%d.%03d", q$Revision: 1.21 $ =~ /(\d+)\.(\d+)/;

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

  } elsif ($method eq "show_texts") {				
    $self->show_texts($mgr);

 } elsif ($method eq "text_trans") { 			 				
    $self->text_trans($mgr);   

 } elsif ($method eq "text_trans_upload") { 						
    $self->show_text_trans_upload($mgr);   

 } elsif ($method eq "text_trans_insert_ok") { 						
    $self->text_trans_insert_ok($mgr);   

 } elsif ($method eq "text_message_user") { 						
    $self->show_text_user_message($mgr);   

 } elsif ($method eq "delete_trans_res") {		
    $self->delete_trans_res($mgr);   
 
 } elsif ($method eq "text_to_trans_download") { 	
    $self->text_to_trans_download($mgr);   

 } elsif ($method eq "res_trans_upload") { 		
    $self->res_trans_upload($mgr);   

 } elsif ($method eq "download_text") { 		
    $self->download_text($mgr);   

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

  my $cat_id          = $mgr->{CGI}->param('cat_id') || '';
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

    if ((defined $check_text) and (defined $mgr->{CGI}->param('text_file'))){$code = $self->Check_Code($mgr, $check_text);}
    
    if ($code==3){ $mgr->{TmplData}{TEXT_ERROR} = $mgr->{Func}->get_text($mgr, 8001);
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
  $mgr->{TmplData}{TEXT_BACK}            =  $self->get_javascript_url_back();
  $mgr->{TmplData}{PAGE_LANG_007001}     = $mgr->{Func}->get_text($mgr, 7001);
  $mgr->{TmplData}{PAGE_LANG_007000}     = $mgr->{Func}->get_text($mgr, 7000);
  $mgr->{TmplData}{TEXT_CAT_NAME}        = $cat[2];
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

  my @texts = $mgr->{Func}->get_cat_texts($mgr, $cat_id);
  my $count = 0;
  my @result;

  # Fill the text loop.
  # TODO: Links, Paging ...
  foreach my $text (@texts) {
    $result[$count]{TEXT_HEADER}  = $text->[1];
    $result[$count]{TEXT_DESC}    = $text->[2];
    $result[$count]{TEXT_LANG}    = $mgr->{Func}->get_lang($mgr, $text->[3]);
    $result[$count]{TEXT_AVG_RAT} = $text->[5];
    $result[$count]{TEXT_NUM_RAT} = $text->[6];
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
  $mgr->{TmplData}{Text_CAT_BACK}    = $mgr->my_url(ACTION => "home");
}





sub get_text {
  my ($self, $mgr, $text_id) = @_;

  my $table_text = $mgr->{Tables}->{TEXT};
  my $dbh        = $mgr->connect();

  my $sth        = $dbh->prepare(<<SQL);

SELECT t.category_id, t.lang_id, t.text_header, t.text_desc, t.text_content  
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


$table = $mgr->{Tables}->{TEXT_RES};

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

my $cat_id 	= $mgr->{Session}->set("TextTransCatID") || undef;
my $trans_data 	= $mgr->{Session}->get("TextTransArt")   || undef;
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
}
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

  my @cat = $mgr->{Func}->get_cat($mgr, $cat_id);


  $mgr->{TmplData}{TEXT_TRANS_ERROR}   	 = $mgr->{Func}->get_text($mgr, 8032);
  $mgr->{TmplData}{TEXT_BACK} = $self->get_javascript_url_back();
  $mgr->{TmplData}{PAGE_LANG_007001}     = $mgr->{Func}->get_text($mgr, 7001);
  $mgr->{TmplData}{PAGE_LANG_007000}     = $mgr->{Func}->get_text($mgr, 7000);
  $mgr->{TmplData}{PAGE_LANG_007012}     = $mgr->{Func}->get_text($mgr, 7012);
  $mgr->{TmplData}{PAGE_LANG_007017}     = $mgr->{Func}->get_text($mgr, 7017);
  $mgr->{TmplData}{PAGE_LANG_007014}     = $mgr->{Func}->get_text($mgr, 7014);
  $mgr->{TmplData}{PAGE_LANG_007015}     = $mgr->{Func}->get_text($mgr, 7015);
  $mgr->{TmplData}{PAGE_LANG_008007}     = $mgr->{Func}->get_text($mgr, 8007);
  $mgr->{TmplData}{PAGE_LANG_008008}     = $mgr->{Func}->get_text($mgr, 8008);



  $mgr->{TmplData}{TEXT_CAT_NAME}        = $cat[2];
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
$loop_data[$counter]{TEXT_HEADER_LINKS}='wwwwwwwwwwwwww';
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
		my @text_langs_check =   $self->get_text_langs($mgr, $text_id);

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


1;










