package modules::Text;

use Class::Singleton;
use base 'Class::Singleton';
use vars qw($VERSION);
use strict;

$VERSION = sprintf "%d.%03d", q$Revision: 1.17 $ =~ /(\d+)\.(\d+)/;

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
  } elsif (defined $mgr->{CGI}->param('text_upload')) {

  } else {
    $self->text_new($mgr);
  }
}

sub text_new {
  my $self = shift;
  my $mgr  = shift;
  my $mode = shift || '';

  my $cat_id    = $mgr->{CGI}->param('cat_id') || '';
  my $text_lang = $mgr->{CGI}->param('text_lang') || '1';

  if ($mode eq "change") {
    $mgr->{TmplData}{TEXT_HEADER} = $mgr->escape($mgr->from_unicode($mgr->{CGI}->param('text_header')));
    $mgr->{TmplData}{TEXT_DESC}   = $mgr->escape($mgr->from_unicode($mgr->{CGI}->param('text_desc')));
    $mgr->{TmplData}{TEXT_TEXT}   = $mgr->escape($mgr->from_unicode($mgr->{CGI}->param('text_text')));

    $cat_id = $mgr->{Session}->get("TextCatId");
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

  my @langs      = $mgr->{Func}->get_langs($mgr);
  my $lang_count = 0;
  my @lang_result;

  foreach my $lang (@langs) {
    if ($lang->[0] == $text_lang) {
      $lang_result[$lang_count]{TEXT_LANG_IF} = 1;
    }

    $lang_result[$lang_count]{TEXT_LANG_ID}   = $lang->[0];
    $lang_result[$lang_count]{TEXT_LANG_NAME} = $lang->[1];
    $lang_count++;
  }

  $mgr->{TmplData}{LOOP_TEXT_LANG} = \@lang_result;
  $mgr->{Template}                 = $mgr->{TmplFiles}->{Text_New};
}

sub text_add {
  my ($self, $mgr) = @_;

  my $text_header = $mgr->unescape($mgr->from_unicode($mgr->{CGI}->param('text_header')));
  my $text_desc   = $mgr->unescape($mgr->from_unicode($mgr->{CGI}->param('text_desc')));
  my $text_text   = $mgr->unescape($mgr->from_unicode($mgr->{CGI}->param('text_text')));
  my $text_lang   = $mgr->{CGI}->param('text_lang');

  my @length_header = split(' ', $text_header);
  my @length_desc   = split(' ', $text_desc);
  my @length_text   = split(' ', $text_text);

  # Count the words plus three. One for each additonal whitespace.
  my $count_words = $#length_header + $#length_desc + $#length_text + 3;
  my $count_error = 0;

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

  if ($count_error) {
    $mgr->{TmplData}{TEXT_ERROR} = $mgr->{Func}->get_text($mgr, 7010);
    $self->text_new($mgr, "change");
    return;
  }

  my $points = $self->text_insert($mgr, $count_words, $text_header, $text_desc, $text_text, $text_lang);
  return if (!defined $points || $points == -1);

  $self->text_insert_ok($mgr, $points, $text_header, $text_desc, $text_text, $text_lang);
}

sub text_insert {
  my ($self, $mgr, $count_words, $text_header, $text_desc, $text_text, $text_lang) = @_;

  my $points = $mgr->{Points}->receive_text($mgr, $mgr->{UserData}->{UserId}, $count_words);
  my $cat_id = $mgr->{Session}->get("TextCatId");

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

  my $sth = $dbh->prepare(sprintf("INSERT INTO %s (text_header, text_desc, text_content,
                                                   num_words, lang_id, user_id, category_id) 
                                   VALUES (?, ?, ?, ?, ?, ?, ?)", $mgr->{Tables}->{TEXT}));

  unless ($sth->execute($text_header, $text_desc, $text_text, $count_words, $text_lang, 
                        $mgr->{UserData}->{UserId}, $cat_id)) {
    warn sprintf("[Error]: Trouble inserting data into table [%s]. Reason: [%s].",
		$mgr->{Tables}->{TEXT}, $dbh->errstr);
    $mgr->fatal_error("Database error.");
  }

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

sub text_insert_ok {
  my ($self, $mgr, $count_words, $text_header, $text_desc, $text_text, $text_lang) = @_;

  my $cat_id = $mgr->{Session}->get("TextCatId");

  my @cat = $mgr->{Func}->get_cat($mgr, $cat_id);

  $mgr->{TmplData}{TEXT_ERROR}       = $mgr->{Func}->get_text($mgr, 7013);
  $mgr->{TmplData}{TEXT_CAT_BACK}    = $mgr->my_url(ACTION => "home");
  $mgr->{TmplData}{PAGE_LANG_007001} = $mgr->{Func}->get_text($mgr, 7001);
  $mgr->{TmplData}{PAGE_LANG_007000} = $mgr->{Func}->get_text($mgr, 7000);
  $mgr->{TmplData}{TEXT_CAT_NAME}    = $cat[2];
  $mgr->{TmplData}{PAGE_LANG_007002} = $mgr->{Func}->get_text($mgr, 7002);
  $mgr->{TmplData}{PAGE_LANG_007003} = $mgr->{Func}->get_text($mgr, 7003);
  $mgr->{TmplData}{PAGE_LANG_007004} = $mgr->{Func}->get_text($mgr, 7004);
  $mgr->{TmplData}{PAGE_LANG_007012} = $mgr->{Func}->get_text($mgr, 7012);
  $mgr->{TmplData}{TEXT_HEADER}      = $mgr->to_unicode($text_header);
  $mgr->{TmplData}{TEXT_DESC}        = $mgr->to_unicode($text_desc);
  $mgr->{TmplData}{TEXT_TEXT}        = $mgr->to_unicode($text_text);
  $mgr->{TmplData}{TEXT_LANG_NAME}   = $mgr->{Func}->get_lang($mgr, $text_lang);
  $mgr->{TmplData}{TEXT_WORDS}       = $count_words;
  $mgr->{TmplData}{PAGE_LANG_007014} = $mgr->{Func}->get_text($mgr, 7014);
  $mgr->{TmplData}{TEXT_POINT_COST}  = $mgr->{Points}->cost_text($mgr, $count_words);
  $mgr->{TmplData}{PAGE_LANG_007015} = $mgr->{Func}->get_text($mgr, 7015);

  $mgr->{Template} = $mgr->{TmplFiles}->{Text_New_Ok};
}

1;
