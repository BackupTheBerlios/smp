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

  # If $mode equal system, then we only select the syste, languages.
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
    push (@langs, [$lang_id, $lang]);
  }

  $sth->finish();

  return @langs;
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

  return $text;
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

SELECT c.cat_id, c.text_count, d.$lang, c.cat_count, c.depth
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
  while (my ($cid, $count, $name, $cats, $depth) = $sth->fetchrow_array()) {
    push (@cats, [$cid, $name, $count, $cats, $depth]);
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
  my $lang  = $mgr->{SystemLangs}->{$mgr->{Language}};

  # Names for the categories and dictionary table.
  my $table_cats = $mgr->{Tables}->{CATS};
  my $table_dict = $mgr->{Tables}->{DICT};

  my $dbh = $mgr->connect();
  my $sth = $dbh->prepare(<<SQL);

SELECT c.cat_id, c.text_count, d.$lang, c.cat_count, c.depth, c.parent_id
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

  return @cat;
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
