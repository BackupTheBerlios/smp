package modules::Help;

use Class::Singleton;
use base 'Class::Singleton';
use vars qw($VERSION);
use strict;

$VERSION = sprintf "%d.%03d", q$Revision: 1.1 $ =~ /(\d+)\.(\d+)/;

#
# this method is called by the manager (main.cgi)
# Params: 1. Manager ref
# Returns true
#
sub parameter 
{
    my ($self, $mgr) = @_;
    my $help_index = $mgr->{CGI}->param('index');

    $self->show_help_page($mgr, $help_index);
}


#
# displays a help page
# Params: 1. Manager ref
#         2. help page index (dictionary index)
# No Return value
#
sub show_help_page
{
    my ($self, $mgr, $help_index) = @_;
    my $lang                      = $mgr->{SystemLangs}->{$mgr->{Language}};

    $mgr->{Template}              = "lingua_help_${lang}_$help_index.tmpl";
    $mgr->{Action}                = "help";
    $mgr->{TmplData}{PAGE_TITLE}  = $mgr->{Func}->get_text($mgr, 2002);
    $mgr->{TmplData}{HELP_INDEX}  = $help_index;
    $mgr->{TmplData}{HELP_MYURL}  = $mgr->my_url();
}

1;
