package modules::User;

use Class::Singleton;
use base 'Class::Singleton';
use vars qw($VERSION);
use strict;

$VERSION = sprintf "%d.%03d", q$Revision: 1.2 $ =~ /(\d+)\.(\d+)/;

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



sub show_pers_page
{
}

1;












