package lib::Rating;

use strict;
use lib::Config;

sub new {
  my $proto = shift;
  my $class = ref($proto) || $proto;
  my $self  = {};

  bless ($self, $class);
}

#-----------------------------------------------------------------------------#
# CALL: $self->set_trans_rating($mgr,$trans_id, $user_id, $rating, $comment); #
#                                                                             #
#       $mgr      = manager object.                                           #
#       $trans_id = ID der Uebersetzung                                       #
#       $user_id  = die ID des Users der diese �bersetzung bewerten will      #
#       $rating   = Bewertung zwischen 1 und 5                                #
#       $comment  = Kommentar zu dieser Bewertung                             #
#                                                                             #
# DESC F�gt eine neue Bewertung zu einer �bersetzung hinzu.                   #
#                                                                             #
# RETURN  1 : alles OK                                                        #
#        -1 : User hat �bersetzung schon bewertet                             #
#        -2 : User darf nicht seine eigene �bersetzung bewerten               #
#        -3 : trans_id ungueltig                                              #
#        -4 : user_id ungueltig                                               #
#        -5 : rating ungueltig                                                #
#-----------------------------------------------------------------------------#

sub set_trans_rating {
  my ($mgr,$trans_id, $user_id, $rating, $comment) = @_;

  return(1);
};

#-----------------------------------------------------------------------------#
# CALL: $self->set_content_rating                                             #
#             ($mgr, $original_id, $user_id, $rating, $comment );             #
#                                                                             #
#       $mgr         = manager object.                                        #
#       $original_id = ID des Textes                                          #
#       $user_id     = die ID des Users der diesen Text bewerten will         #
#       $rating      = Bewertung zwischen 1 und 5                             #
#       $comment     = Kommentar zu dieser Bewertung                          #
#                                                                             #
# DESC F�gt eine neue Bewertung des Inhalts eines Textes hinzu.               #
#                                                                             #
# RETURN  1 : alles OK                                                        #
#        -1 : User hat Text schon bewertet                                    #
#        -2 : User darf nicht seinen eigenen Text bewerten                    #
#        -3 : original_id ungueltig                                           #
#        -4 : user_id ungueltig                                               #
#        -5 : rating ungueltig                                                #
#-----------------------------------------------------------------------------#

sub set_content_rating {
  my ($mgr, $original_id, $user_id, $rating, $comment) = @_;

  return(1);
};

#-----------------------------------------------------------------------------#
# CALL: $self->del_text_rating( $mgr, $original_id );                         #
#                                                                             #
#       $mgr         = manager object.                                        #
#       $original_id = ID des Textes                                          #
#                                                                             #
# DESC L�scht alle Inhalts-Bewertungen zu einem Text.                         #
#                                                                             #
# RETURN  1 : alles OK                                                        #
#        -1 : original_id ungueltig                                           #
#        -2 : User darf keine Bewertungen loeschen                            #
#-----------------------------------------------------------------------------#

sub del_text_rating {
  my ( $mgr, $original_id ) = @_;

  return(1);
};

#-----------------------------------------------------------------------------#
# CALL: $self->del_trans_rating( $mgr, $trans_id );                           #
#                                                                             #
#       $mgr      = manager object.                                           #
#       $trans_id = ID der �bersetzung                                        #
#                                                                             #
# DESC L�scht alle �bersetzungs-Bewertungen                                   #
#      (Beim loeschen eines Textes inklusive aller �bersetzungen mu� diese    #
#      Funktion f�r jede �bersetzung aufgerufen werden!)                      #
#                                                                             #
# RETURN  1 : alles OK                                                        #
#        -1 : trans_id ungueltig                                              #
#        -2 : User darf keine Bewertungen loeschen                            #
#-----------------------------------------------------------------------------#

sub del_trans_rating {
  my ( $mgr, $trans_id ) = @_;

  return(1);
};

#-----------------------------------------------------------------------------#
# CALL: $self->get_average_trans_rating( $mgr, $trans_id );                   #
#                                                                             #
#       $mgr      = manager object.                                           #
#       $trans_id = ID der �bersetzung                                        #
#                                                                             #
# DESC Liefert die Durchschnittliche Bewertung einer �bersetzung zur�ck.      #
#                                                                             #
# RETURN 1.0 .. 5.0 : durchschnittliche Bewertung                             #
#        -1 : trans_id ungueltig                                              #
#-----------------------------------------------------------------------------#

sub get_average_trans_rating {
  my ( $mgr, trans_id ) = @_;

  return(1);
};

#-----------------------------------------------------------------------------#
# CALL: $self->get_average_content_rating( $mgr, $original_id );              #
#                                                                             #
#       $mgr         = manager object.                                        #
#       $original_id = ID des Textes                                          #
#                                                                             #
# DESC Liefert die durchschnittliche Bewertung des Inhaltes eines Textes      #
#      zur�ck.                                                                #
#                                                                             #
# RETURN 1.0 .. 5.0 : durchschnittliche Bewertung                             #
#        -1 : original_id ungueltig                                           #
#-----------------------------------------------------------------------------#

sub get_average_content_rating {
  my ( $mgr, trans_id ) = @_;

  return(1);
};

1;

