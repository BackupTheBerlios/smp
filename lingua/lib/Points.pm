package lib::Points;

use strict;

sub new {
  my $proto = shift;
  my $class = ref($proto) || $proto;
  my $self  = {};

  bless ($self, $class);
}

#-----------------------------------------------------------------------------#
# CALL: $self->receive_text($mgr, $user_id, $words).                          #
#                                                                             #
#       $mgr     = manager object.                                            #
#       $user_id = die ID des Users der diesen Text einstellen will           #
#       $words   = Anzahl der Worte des Textes                                #
#                                                                             #
# DESC Wenn ein neuer Text in die Community gestellt werden soll, �bernimmt   #
#      diese Funktion die entsprechenden Punkteverwaltungsdinge.              #
#                                                                             #
# RETURN ( $points )                                                          #
#                                                                             #
#       $points : Punktekosten f�r diesen Text                                #
#                 Ist $points negativ, besitzt der User nicht genug           #
#                 Punkte um diesen Text reinzustellen. Die Punkte werden      #
#                 nat�rlich nicht abgezogen.                                  #
#-----------------------------------------------------------------------------#
sub receive_text {

  return 1;
};

#-----------------------------------------------------------------------------#
# CALL: $self->receive_trans($mgr, $user_id, $words).                         #
#                                                                             #
#       $mgr     = manager object.                                            #
#       $user_id = die ID des Users der diese �bersetzung erstellt hat        #
#       $words   = Anzahl der Worte der �bersetzung                           #
#                                                                             #
# DESC Wenn ein neue �bersetzung in die Community gestellt werden soll,       #
#      �bernimmt diese Funktion die entsprechenden Punkteverwaltungsdinge.    #
#                                                                             #
# RETURN ( $points )                                                          #
#                                                                             #
#       $points : Punkte die f�r diese �bersetzung gutgeschrieben werden      #
#                 (inaktiv)                                                   #
#-----------------------------------------------------------------------------#
sub receive_trans {

  return 1;
};

#-----------------------------------------------------------------------------#
# CALL: $self->get_activ_points($mgr, $user_id).                              #
#                                                                             #
#       $mgr     = manager object.                                            #
#       $user_id = die ID des Users dessen Punktestand gefragt ist            #
#                                                                             #
# DESC Liefert die aktiven Punkte des Users zur�ck                            #
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

  return $points;
};

#-----------------------------------------------------------------------------#
# CALL: $self->get_inactiv_points($mgr, $user_id).                            #
#                                                                             #
#       $mgr     = manager object.                                            #
#       $user_id = die ID des Users dessen Punktestand gefragt ist            #
#                                                                             #
# DESC Liefert die aktiven Punkte des Users zur�ck                            #
#                                                                             #
# RETURN ( $points )                                                          #
#                                                                             #
#       $points : Ist $points negativ, existiert die user_id nicht            #
#-----------------------------------------------------------------------------#
sub get_inactiv_points {

  return 1;
};




1;




