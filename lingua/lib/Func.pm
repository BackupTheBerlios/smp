package lib::Func;

use strict;

sub new {
  my $proto = shift;
  my $class = ref($proto) || $proto;
  my $self  = {};

  bless ($self, $class);
}

#-----------------------------------------------------------------------------#
# CALL: $self->get_langs($mgr, $mode).                                        #
#                                                                             #
#       $mgr     = manager object.                                            #
#       $mode    = only system languages "system" or "".                      #
#-----------------------------------------------------------------------------#
sub get_langs {
  my ($self, $mgr, $mode) = @_;

  # Get the languages table name from the current system languages.
  my $lang       = $mgr->{SystemLangs}->{$mgr->{Language}};

  my $table_dict = $mgr->{Tables}->{DICT};
  my $table_lang = $mgr->{Tables}->{LANG};
  my $dbh        = $mgr->connect();

  my $more = "";

  # If $mode equal system, then we only select the syste, languages.]
  if ((defined $mode) && ($mode eq "system")) {
    $more = "AND l.system_lang = '1'";
  }

  # Select all the languages from the database with the current translation
  # name from the dictionary table.
  my $sth        = $dbh->prepare(<<SQL);

SELECT l.lang_id, d.$lang
FROM   $table_dict d , $table_lang l
WHERE  l.lang_name_id = d.dict_id $more

SQL

  unless ($sth->execute()) {
    warn sprintf("[Error:] Trouble selecting data from [%s] and [%s].".
	         "Reason: [%s].", $table_dict, $table_lang, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }

  my @langs;

  # Push the languages id and the languages name into the @lang array.
  while (my ($lang_id, $lang) = $sth->fetchrow_array()) {

    push (@langs, [$lang_id, $mgr->to_unicode($lang)]);	    #geändert: Giovanni N.
  }

  $sth->finish();

  return @langs;
}

#-----------------------------------------------------------------------------#
# CALL: $self->get_lang($mgr, $lang_id).                                      #
#                                                                             #
#       $mgr     = manager object.                                            #
#       $lang_id = id of the choosen lang.                                    #
#-----------------------------------------------------------------------------#
sub get_lang {
  my ($self, $mgr, $lang_id) = @_;

  # Get the languages table name from the current system languages.
  my $lang       = $mgr->{SystemLangs}->{$mgr->{Language}};

  my $table_dict = $mgr->{Tables}->{DICT};
  my $table_lang = $mgr->{Tables}->{LANG};
  my $dbh        = $mgr->connect();

  # Select all the languages from the database with the current translation
  # name from the dictionary table.
  my $sth        = $dbh->prepare(<<SQL);

SELECT d.$lang
FROM   $table_dict d , $table_lang l
WHERE  l.lang_id = ? AND l.lang_name_id = d.dict_id

SQL

  unless ($sth->execute($lang_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s] and [%s].".
	         "Reason: [%s].", $table_dict, $table_lang, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }

  my $lang_name = $sth->fetchrow_array();

  $sth->finish();

   return $mgr->to_unicode($lang_name);    #geändert: Giovanni N.
}

#-----------------------------------------------------------------------------#
# CALL: $self->get_text($mgr, $dict_id).                                      #
#                                                                             #
#       $mgr     = manager object.                                            #
#       $dict_id = id of the text.                                            #
#-----------------------------------------------------------------------------#
sub get_text {
  my ($self, $mgr, $dict_id) = @_;

  # Language table name from the current system language.
  my $lang  = $mgr->{SystemLangs}->{$mgr->{Language}};

  # Table name for dictionary table.
  my $table = $mgr->{Tables}->{DICT};

  my $dbh = $mgr->connect();
  my $sth = $dbh->prepare(<<SQL);

SELECT $lang
FROM   $table
WHERE  dict_id = ?

SQL

  unless ($sth->execute($dict_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
		 "Reason: [%s].", $table, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }

  # Get the text value from the dictionary table.
  my $text = $sth->fetchrow_array();

  $sth->finish();

  return $mgr->to_unicode($text);  #geändert: Giovanni N.
}

#-----------------------------------------------------------------------------#
# CALL: $self->get_cats($mgr, $cat_id).                                       #
#                                                                             #
#       $mgr     = manager object.                                            #
#       $dict_id = id of the parent_cat.                                      #
#-----------------------------------------------------------------------------#
sub get_cats {
  my ($self, $mgr, $cat_id) = @_;

  # Language table name from the current system language.
  my $lang  = $mgr->{SystemLangs}->{$mgr->{Language}};

  # Names for the categories and dictionary table.
  my $table_cats = $mgr->{Tables}->{CATS};
  my $table_dict = $mgr->{Tables}->{DICT};

  my $dbh = $mgr->connect();
  my $sth = $dbh->prepare(<<SQL);

SELECT c.cat_id, c.text_count, d.$lang, c.cat_count, c.depth, c.status
FROM $table_cats c, $table_dict d
WHERE d.dict_id = c.lang_id AND c.parent_id = ?

SQL

  unless ($sth->execute($cat_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s] and [%s].".
	         "Reason: [%s].", $table_cats, $table_dict, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }

  my @cats;

  # Push all the selected values into an array.
  while (my ($cid, $count, $name, $cats, $depth, $status) = $sth->fetchrow_array()) {
    push (@cats, [$cid, $mgr->to_unicode($name), $count, $cats, $depth, $status]);     #geändert: Giovanni N.
  }

  $sth->finish();

  return @cats;
}


#-----------------------------------------------------------------------------#
# CALL: $self->get_cat($mgr, $cat_id).                                        #
#                                                                             #
#       $mgr     = manager object.                                            #
#       $dict_id = id of the parent_cat.                                      #
#-----------------------------------------------------------------------------#
sub get_cat {
  my ($self, $mgr, $cat_id) = @_;

  # Language table name from the current system language.
  my $lang = $mgr->{SystemLangs}->{$mgr->{Language}};

  # Names for the categories and dictionary table.
  my $table_cats = $mgr->{Tables}->{CATS};
  my $table_dict = $mgr->{Tables}->{DICT};

  my $dbh = $mgr->connect();
  my $sth = $dbh->prepare(<<SQL);

SELECT c.cat_id, c.text_count, d.$lang, c.cat_count, c.depth, c.parent_id, c.status, c.lang_id
FROM $table_cats c, $table_dict d
WHERE d.dict_id = c.lang_id AND c.cat_id = ?

SQL

  unless ($sth->execute($cat_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s] and [%s].".
	         "Reason: [%s].", $table_cats, $table_dict, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }

  # Push all the selected values into an array.
  my (@cat) = $sth->fetchrow_array();

  $sth->finish();

 $cat[2]= $mgr->to_unicode($cat[2]);   #geändert: Giovanni N.

  return @cat;
}

#-----------------------------------------------------------------------------#
# CALL: $self->get_cat_texts($mgr, $cat_id).                                  #
#                                                                             #
#       $mgr    = manager object.                                             #
#       $cat_id = category id.                                                #
#-----------------------------------------------------------------------------#
sub get_cat_texts {
  my ($self, $mgr, $cat_id) = @_;

  my $table_text = $mgr->{Tables}->{TEXT};

  my $dbh = $mgr->connect();
  my $sth = $dbh->prepare(<<SQL);

SELECT text_id, text_header, text_desc, lang_id, user_id, avg_rating, num_ratings
FROM $table_text
WHERE category_id = ? AND parent_id = '0' AND status = '1'

SQL

  unless ($sth->execute($cat_id)) {
    warn sprintf("[Error:] Trouble selecting data from [%s].".
	         "Reason: [%s].", $table_text, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  }

  my @texts;

  while (my ($id, $header, $desc, $name, $uid, $rating, $num_rat) = $sth->fetchrow_array()) {
    push (@texts, [$id, $header, $desc, $name, $uid, $rating,  $num_rat]);
  }

  $sth->finish();

  return @texts;
}

#-----------------------------------------------------------------------------#
# CALL: $self->check_for_user($mgr, $user_type).                              #
#                                                                             #
#       $mgr       = manager object.                                          #
#       $user_type = user type.                                               #
#-----------------------------------------------------------------------------#
sub check_for_user {
  my ($self, $mgr, $user_type) = @_;

  if ($mgr->{Session}->check_sid($mgr->{SessionId})) {
    if ($mgr->{UserData}->{UserLevel} ne $user_type) {
      return undef;
    }
  }

  return 1;
}

1;

