package modules::Text;

use Class::Singleton;
use base 'Class::Singleton';
use vars qw($VERSION);
use strict;

$VERSION = sprintf "%d.%03d", q$Revision: 1.19 $ =~ /(\d+)\.(\d+)/;

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
  } else {
    $self->text_new($mgr);
  }
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

  # If mode eq "change", we fill the form again.
  if ($mode eq "change") {
    $mgr->{TmplData}{TEXT_HEADER} = $mgr->escape($mgr->from_unicode($mgr->{CGI}->param('text_header')));
    $mgr->{TmplData}{TEXT_DESC}   = $mgr->escape($mgr->from_unicode($mgr->{CGI}->param('text_desc')));
    $mgr->{TmplData}{TEXT_TEXT}   = $mgr->escape($mgr->from_unicode($mgr->{CGI}->param('text_text')));

    $cat_id    = $mgr->{Session}->get("TextCatId");
  # If we came from the upload form, we fill the form again.
  } elsif ($mode eq "upload_back") {
    $mgr->{TmplData}{TEXT_HEADER} = $mgr->escape($mgr->from_unicode($mgr->{Session}->get("TextHeader")));
    $mgr->{TmplData}{TEXT_DESC}   = $mgr->escape($mgr->from_unicode($mgr->{Session}->get("TextDesc")));

    my $check_text = $mgr->{Session}->get("TextText");
    my $tmp_text   = "";
    my $unicode;

    # Simple unicode check.
    eval { $unicode = latin($check_text); $tmp_text = $unicode->utf8($check_text); };

    if ($@) {
      $mgr->{TmplData}{TEXT_TEXT} = $mgr->escape($check_text);
    } else {
      $mgr->{TmplData}{TEXT_TEXT} = $mgr->escape($tmp_text);
    }

    $text_lang_trans = $mgr->{Session}->get("TextLangTrans");
    $text_lang       = $mgr->{Session}->get("TextLang");
    $cat_id          = $mgr->{Session}->get("TextCatId");
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

  $mgr->{TmplData}{LOOP_TEXT_LANG_TRANS} = \@lang_trans_result;
  $mgr->{TmplData}{LOOP_TEXT_LANG}       = \@lang_result;
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
  my $text_header     = $mgr->unescape($mgr->from_unicode($mgr->{CGI}->param('text_header')));
  my $text_desc       = $mgr->unescape($mgr->from_unicode($mgr->{CGI}->param('text_desc')));
  my $text_text       = $mgr->unescape($mgr->from_unicode($mgr->{CGI}->param('text_text')));
  my $text_lang       = $mgr->{CGI}->param('text_lang');
  my $text_lang_trans = $mgr->{CGI}->param('text_lang_trans');

  my @length_header = split(' ', $text_header);
  my @length_desc   = split(' ', $text_desc);
  my @length_text   = split(' ', $text_text);

  # Count the words plus three. One for each additonal whitespace.
  my $count_words = $#length_header + $#length_desc + $#length_text + 3;
  my $count_error = 0;

  # Catch and count the errors.
  if ($text_header eq '') {
    $mgr->{TmplData}{TEXT_ERROR_HEADER} = $mgr->{Func}->get_text($mgr, 7007);
    $count_error++;
  }

  if ($text_desc eq '') {
    $mgr->{TmplData}{TEXT_ERROR_DESC} = $mgr->{Func}->get_text($mgr, 7008);
    $count_error++;
  }

  if ($text_text eq '') {
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
  $self->text_insert_ok($mgr, $points, $text_header, $text_desc, $text_text, 
			$text_lang, $text_lang_trans);
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
  $mgr->{TmplData}{TEXT_ADD_BACK}    = $mgr->my_url(METHOD => "upload_back");

  my $text_header     = $mgr->{CGI}->param('text_header');
  my $text_desc       = $mgr->{CGI}->param('text_desc');
  my $text_text       = $mgr->{CGI}->param('text_text');
  my $text_lang       = $mgr->{CGI}->param('text_lang');
  my $text_lang_trans = $mgr->{CGI}->param('text_lang_trans');

  # Set the form value from the text_new form.
  $mgr->{Session}->set("TextHeader", $text_header);
  $mgr->{Session}->set("TextDesc", $text_desc);
  $mgr->{Session}->set("TextText", $text_text);
  $mgr->{Session}->set("TextLang", $text_lang);
  $mgr->{Session}->set("TextLangTrans", $text_lang_trans);

  # Show the upload form.
  $mgr->{Template} = $mgr->{TmplFiles}->{Text_New_Upload};
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
  my $size       = 0;
  my ($buffer, $text);

  # Read 2048 bytes from the choosen file.
  while ($bytes_read = read($file_path, $buffer, 2048)) {
    $size += $bytes_read;
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
  my ($self, $mgr, $count_words, $text_header, $text_desc, 
      $text_text, $text_lang, $text_lang_trans) = @_;

  my $cat_id = $mgr->{Session}->get("TextCatId");

  my @cat = $mgr->{Func}->get_cat($mgr, $cat_id);

  $mgr->{TmplData}{TEXT_ERROR}           = $mgr->{Func}->get_text($mgr, 7013);
  $mgr->{TmplData}{TEXT_CAT_BACK}        = $mgr->my_url(ACTION => "home");
  $mgr->{TmplData}{PAGE_LANG_007001}     = $mgr->{Func}->get_text($mgr, 7001);
  $mgr->{TmplData}{PAGE_LANG_007000}     = $mgr->{Func}->get_text($mgr, 7000);
  $mgr->{TmplData}{TEXT_CAT_NAME}        = $cat[2];
  $mgr->{TmplData}{PAGE_LANG_007002}     = $mgr->{Func}->get_text($mgr, 7002);
  $mgr->{TmplData}{PAGE_LANG_007003}     = $mgr->{Func}->get_text($mgr, 7003);
  $mgr->{TmplData}{PAGE_LANG_007004}     = $mgr->{Func}->get_text($mgr, 7004);
  $mgr->{TmplData}{PAGE_LANG_007012}     = $mgr->{Func}->get_text($mgr, 7012);
  $mgr->{TmplData}{PAGE_LANG_007017}     = $mgr->{Func}->get_text($mgr, 7017);
  $mgr->{TmplData}{TEXT_HEADER}          = $text_header;
  $mgr->{TmplData}{TEXT_DESC}            = $text_desc;
  $mgr->{TmplData}{TEXT_TEXT}            = $text_text;
  $mgr->{TmplData}{TEXT_LANG_NAME}       = $mgr->{Func}->get_lang($mgr, $text_lang);
  $mgr->{TmplData}{TEXT_LANG_TRANS_NAME} = $mgr->{Func}->get_lang($mgr, $text_lang_trans);
  $mgr->{TmplData}{TEXT_WORDS}           = $count_words;
  $mgr->{TmplData}{PAGE_LANG_007014}     = $mgr->{Func}->get_text($mgr, 7014);
  $mgr->{TmplData}{TEXT_POINT_COST}      = $mgr->{Points}->cost_text($mgr, $count_words);
  $mgr->{TmplData}{PAGE_LANG_007015}     = $mgr->{Func}->get_text($mgr, 7015);

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

1;
