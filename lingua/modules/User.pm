package modules::User;

use Class::Singleton;
use base 'Class::Singleton';
use vars qw($VERSION);
use strict;

$VERSION = sprintf "%d.%03d", q$Revision: 1.1 $ =~ /(\d+)\.(\d+)/;

#
# this method is called by the manager (main.cgi)
#
sub parameter {
    my ($self, $mgr) = @_;

    $mgr->{Template} = $mgr->{TmplFiles}->{User_Pers};

    $mgr->{Page}->fill_main_part($mgr);
    $mgr->{Page}->fill_user_part($mgr);
    $mgr->{Page}->fill_lang_part($mgr);

    $self->show_pers_page($mgr, 1);

    return 1;
}



#
# fills the template vars of lingua_user_pers.tmpl
# there are 4 variables:
#   two are taken from the dictionary (and should thus change their values when
#     you change the language of the system)
#   the other two are taken from the lingua_user table in the database via 
#     select statement
#
sub show_pers_page
{
    my ($self, $mgr) = @_;

    $mgr->{TmplData}{PAGE_LANG_001001} = $mgr->{Func}->get_text($mgr, 1001);
    $mgr->{TmplData}{PAGE_LANG_001002} = $mgr->{Func}->get_text($mgr, 1002);

    $mgr->{Action} = "user";
    $mgr->{TmplData}{PAGE_TITLE} = $mgr->{Func}->get_text($mgr, 1001);

    my $table = $mgr->{Tables}->{USER};

    my $dbh = $mgr->connect();

    $dbh->do("LOCK TABLES $table WRITE");
    my $sth = $dbh->prepare(<<SQL);

SELECT firstname, lastname
FROM $table
WHERE user_id = ?

SQL
   
    unless ($sth->execute($mgr->{Session}->get("UserId"))) 
    {
	warn sprintf("[Error:] Trouble selecting from %s. " .
		     "Reason: [%s].", $table, $dbh->errstr());
	$dbh->do("UNLOCK TABLES");
	$mgr->fatal_error("Database error.");
    }

    my $data = $sth->fetchrow_arrayref();
    
    $dbh->do("UNLOCK TABLES");

    $mgr->{TmplData}{USER_FIRSTNAME} = $data->[0];
    $mgr->{TmplData}{USER_LASTNAME}  = $data->[1];

    $sth->finish();
}

1;









