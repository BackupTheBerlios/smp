package lib::Points;

use strict;

sub new {
  my $proto = shift;
  my $class = ref($proto) || $proto;
  my $self  = {};

  bless ($self, $class);
};

#-----------------------------------------------------------------------------#
# CALL: $self->update_points($mgr, $user_id).                                 #
#                                                                             #
#       $mgr     = manager object.                                            #
#       $user_id = die ID des Users der diesen Text einstellen will           #
#                                                                             #
# DESC Jedes mal, wenn sich ein User einloggt, sollte diese Funktion          #
#      aufgerufen werden. Sie prüft, ob inaktive Punkte zu aktiven werden und #
#      wandelt diese dann entsprechend um.                                    #
#-----------------------------------------------------------------------------#
sub update_points {
  my ($self, $mgr, $user_id) = @_;

  my $dbh = $mgr->connect();
  unless ($dbh->do("LOCK TABLES $mgr->{Tables}->{POINTS_INACTIV} WRITE, $mgr->{Tables}->{USER} WRITE")) {
    warn sprintf("[Error]: Trouble locking table [%s]. Reason: [%s].",$mgr->{Tables}->{POINTS_INACTIV}, $dbh->ersstr);
  };

  my $sth = $dbh->prepare(qq{SELECT sum(points) FROM $mgr->{Tables}->{POINTS_INACTIV} WHERE 
                             ( (userid = $user_id) AND (TO_DAYS(NOW()) >= TO_DAYS(insert_date)+ ($mgr->{InactivTime}) )) });

  unless ($sth->execute()) {
    warn sprintf("[Error:] Trouble selecting data from [%s] and [%s].".
	         "Reason: [%s].", $mgr->{Tables}->{POINTS_INACTIV}, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  };

  my $points = $sth->fetchrow_array();

  if ((defined $points) && ($points > 0)) {
    $sth = $dbh->prepare(qq{ UPDATE $mgr->{Tables}->{USER} SET points=points+$points });

    unless ($sth->execute()) {
      warn sprintf("[Error:] Trouble selecting data from [%s] and [%s].".
  	         "Reason: [%s].", $mgr->{Tables}->{POINTS_INACTIV}, $dbh->errstr());
      $mgr->fatal_error("Database error.");
    };

    $sth = $dbh->prepare(qq{ DELETE FROM $mgr->{Tables}->{POINTS_INACTIV} WHERE 
       ((userid = $user_id) AND (TO_DAYS(NOW()) >= TO_DAYS(insert_date)+ ($mgr->{InactivTime})))});

    unless ($sth->execute()) {
      warn sprintf("[Error:] Trouble selecting data from [%s] and [%s].".
  	         "Reason: [%s].", $mgr->{Tables}->{POINTS_INACTIV}, $dbh->errstr());
      $mgr->fatal_error("Database error.");
    };

  };

  $sth->finish();
  $dbh->do("UNLOCK TABLES");
  
  return 1;
};

#-----------------------------------------------------------------------------#
# CALL: $self->cost_text($mgr, $user_id, $words).                             #
#                                                                             #
#       $mgr     = manager object.                                            #
#       $user_id = die ID des Users der diesen Text einstellen will           #
#       $words   = Anzahl der Worte des Textes                                #
#                                                                             #
# DESC Ermittelt die Kosten zum Reinstellen eines Textes                      #
#                                                                             #
# RETURN ( $points )                                                          #
#                                                                             #
#       $points : Punktekosten für diesen Text                                #
#-----------------------------------------------------------------------------#
sub cost_text {

  my ($self, $mgr, $user_id, $words) = @_;

  return ($mgr->{TextPoints}) * $words;
};

#-----------------------------------------------------------------------------#
# CALL: $self->receive_text($mgr, $user_id, $words).                          #
#                                                                             #
#       $mgr     = manager object.                                            #
#       $user_id = die ID des Users der diesen Text einstellen will           #
#       $words   = Anzahl der Worte des Textes                                #
#                                                                             #
# DESC Wenn ein neuer Text in die Community gestellt werden soll, übernimmt   #
#      diese Funktion die entsprechenden Punkteverwaltungsdinge.              #
#                                                                             #
# RETURN ( $points )                                                          #
#                                                                             #
#       $points : Punktekosten für diesen Text                                #
#                 Ist $points negativ, besitzt der User nicht genug           #
#                 Punkte um diesen Text reinzustellen. Die Punkte werden      #
#                 natürlich nicht abgezogen.                                  #
#-----------------------------------------------------------------------------#
sub receive_text {

  my ($self, $mgr, $user_id, $words) = @_;

  my $pointscost = ($mgr->{TextPoints}) * $words;

  if ($self->get_activ_points($mgr, $user_id) >= $pointscost) {

    my $dbh = $mgr->connect();
    unless ($dbh->do("LOCK TABLES $mgr->{Tables}->{POINTS_INACTIV} WRITE")) {
      warn sprintf("[Error]: Trouble locking table [%s]. Reason: [%s].",$mgr->{Tables}->{POINTS_INACTIV}, $dbh->ersstr);
    };

    my $sth = $dbh->prepare(qq{UPDATE $mgr->{Tables}->{USER} SET points=points-$pointscost });

    unless ($sth->execute()) {
      warn sprintf("[Error:] Trouble selecting data from [%s] and [%s].".
        	         "Reason: [%s].", $mgr->{Tables}->{POINTS_INACTIV}, $dbh->errstr());
      $mgr->fatal_error("Database error.");
    };

    $sth->finish();
    $dbh->do("UNLOCK TABLES");

    return ($pointscost);
    
  } else {
    return (-1);
  }
};

#-----------------------------------------------------------------------------#
# CALL: $self->cost_trans($mgr, $user_id, $words, $trans_id).                 #
#                                                                             #
#       $mgr      = manager object.                                           #
#       $user_id  = die ID des Users der diese Übersetzung erstellt hat       #
#       $words    = Anzahl der Worte der Übersetzung                          #
#       $trans_id = ID der Übersetzung                                        #
#                                                                             #
# DESC Ermittelt die Punkte die für eine Übersetzung gutgeschrieben werden.   #
#                                                                             #
# RETURN ( $points )                                                          #
#                                                                             #
#       $points : Punkte die für diese Übersetzung gutgeschrieben werden      #
#                 (inaktiv)                                                   #
#-----------------------------------------------------------------------------#
sub cost_trans {

  my ($self, $mgr, $user_id, $words, $trans_id) = @_;

  return ($mgr->{TransPoints} * $words);
};


#-----------------------------------------------------------------------------#
# CALL: $self->receive_trans($mgr, $user_id, $words, $trans_id).              #
#                                                                             #
#       $mgr      = manager object.                                           #
#       $user_id  = die ID des Users der diese Übersetzung erstellt hat       #
#       $words    = Anzahl der Worte der Übersetzung                          #
#       $trans_id = ID der Übersetzung                                        #
#                                                                             #
# DESC Wenn ein neue Übersetzung in die Community gestellt werden soll,       #
#      übernimmt diese Funktion die entsprechenden Punkteverwaltungsdinge.    #
#                                                                             #
# RETURN ( $points )                                                          #
#                                                                             #
#       $points : Punkte die für diese Übersetzung gutgeschrieben werden      #
#                 (inaktiv)                                                   #
#-----------------------------------------------------------------------------#
sub receive_trans {

  my ($self, $mgr, $user_id, $words, $trans_id) = @_;

  my $dbh = $mgr->connect();
  unless ($dbh->do("LOCK TABLES $mgr->{Tables}->{POINTS_INACTIV} WRITE")) {
    warn sprintf("[Error]: Trouble locking table [%s]. Reason: [%s].",$mgr->{Tables}->{POINTS_INACTIV}, $dbh->ersstr);
  };

  my $now = sprintf("%04d-%02d-%02d %02d:%02d:%02d",
            sub {($_[0]+1900, $_[1]+1),@_[2..5]}->((localtime)[5,4,3,2,1,0]));

  my $sth = $dbh->prepare(qq{INSERT INTO $mgr->{Tables}->{POINTS_INACTIV} (userid, insert_date, translation_id, points) VALUES
                            ($user_id, NOW(), $trans_id, (($mgr->{TransPoints}) * $words)) });

  unless ($sth->execute()) {
    warn sprintf("[Error:] Trouble selecting data from [%s] and [%s].".
	         "Reason: [%s].", $mgr->{Tables}->{POINTS_INACTIV}, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  };

  $sth->finish();
  $dbh->do("UNLOCK TABLES");

  return ($mgr->{TransPoints} * $words);
};

#-----------------------------------------------------------------------------#
# CALL: $self->get_activ_points($mgr, $user_id).                              #
#                                                                             #
#       $mgr     = manager object.                                            #
#       $user_id = die ID des Users dessen Punktestand gefragt ist            #
#                                                                             #
# DESC Liefert die aktiven Punkte des Users zurück                            #
#                                                                             #
# RETURN ( $points )                                                          #
#                                                                             #
#       $points : Ist $points negativ, existiert die user_id nicht            #
#-----------------------------------------------------------------------------#
sub get_activ_points {

  my ($self, $mgr, $user_id) = @_;

  my $dbh = $mgr->connect();
  unless ($dbh->do("LOCK TABLES $mgr->{Tables}->{USER} READ")) {
    warn sprintf("[Error]: Trouble locking table [%s]. Reason: [%s].",$mgr->{Tables}->{USER}, $dbh->ersstr);
  };

  my $sth = $dbh->prepare(qq{SELECT points FROM $mgr->{Tables}->{USER} WHERE  user_id = $user_id});

  unless ($sth->execute()) {
    warn sprintf("[Error:] Trouble selecting data from [%s] and [%s].".
	         "Reason: [%s].", $mgr->{Tables}->{USER}, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  };

  my $points = $sth->fetchrow_array();

  $sth->finish();
  $dbh->do("UNLOCK TABLES");

  if ((defined $points) && ($points >= 0)) { 
    return $points;
  } else {
    return(-1);
  };
};

#-----------------------------------------------------------------------------#
# CALL: $self->get_inactiv_points($mgr, $user_id).                            #
#                                                                             #
#       $mgr     = manager object.                                            #
#       $user_id = die ID des Users dessen Punktestand gefragt ist            #
#                                                                             #
# DESC Liefert die aktiven Punkte des Users zurück                            #
#                                                                             #
# RETURN ( $points )                                                          #
#                                                                             #
#       $points : Ist $points negativ, existiert die user_id nicht            #
#-----------------------------------------------------------------------------#
sub get_inactiv_points {

  my ($self, $mgr, $user_id) = @_;

  my $dbh = $mgr->connect();
  unless ($dbh->do("LOCK TABLES $mgr->{Tables}->{POINTS_INACTIV} READ")) {
    warn sprintf("[Error]: Trouble locking table [%s]. Reason: [%s].",$mgr->{Tables}->{POINTS_INACTIV}, $dbh->ersstr);
  };

  my $sth = $dbh->prepare(qq{SELECT sum(points) FROM $mgr->{Tables}->{POINTS_INACTIV} WHERE  userid = $user_id});

  unless ($sth->execute()) {
    warn sprintf("[Error:] Trouble selecting data from [%s] and [%s].".
	         "Reason: [%s].", $mgr->{Tables}->{POINTS_INACTIV}, $dbh->errstr());
    $mgr->fatal_error("Database error.");
  };

  my $points = $sth->fetchrow_array();

  $sth->finish();
  $dbh->do("UNLOCK TABLES");

  return $points;
};

1;



