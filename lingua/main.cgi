#!/usr/bin/perl -w

package main;

use CGI qw(standard);
use DBI;
use HTML::Template;
use lib::Config;
use lib::Func;
use lib::Page;
use lib::Session;
use Unicode::String qw(latin1 utf8 utf16);
use fields (
	    'Action',              # Current action name.
	    'CGI',                 # CGI object.
	    'Charset',             # Current charset (utf8, utf16, utf32).
	    'DbData',              # Hashref with the database data.
	    'DbHandle',            # Database handle.
	    'DefaultAction',       # Default action name.
	    'DefaultModule',       # Hashref with the default module.
	    'Func',                # Func object.
	    'Language',            # Current system language.
	    'LoginOk',             # If this is true, a right session is set.
	    'ModuleDir',           # Module directory.
	    'ModuleHandlesOutput', # If this is true, no output call at end of the handler function.
	    'Modules',             # Array from all avalible modules.
	    'MyUrl',               # Current url of this script here with action.
	    'Page',                # Page object.
	    'ScriptName',          # Script name.
	    'Session',             # Session object.
	    'SessionData',         # Hashref with all session config data.
	    'SessionId',           # Current session id.
	    'SystemLangs',         # Hashref with all system languages.
	    'Tables',              # Hashref with all tables.
	    'Template',            # Current template.
	    'TmplData',            # Template data.
	    'TmplDir',             # Template directory.
	    'TmplFiles',           # Hashref with all templates.
	    'UserData'             # Hashref with current user data..
);
use vars qw(%FIELDS $VERSION);
use strict;

$VERSION = sprintf "%d.%03d", q$Revision: 1.1 $ =~ /(\d+)\.(\d+)/;

&handler();

sub handler {
  my $self = __PACKAGE__->new (
			       Action              => undef,
			       CGI                 => CGI->new(),
			       Charset             => $lib::Config::CONFIG->{Charset},
			       DbData              => $lib::Config::DB,
			       DbHandle            => undef,
			       DefaultAction       => $lib::Config::CONFIG->{DefaultModule}->{action},
			       DefaultModule       => $lib::Config::CONFIG->{DefaultModule}->{script},
			       Func                => lib::Func->new(),
			       Language            => 1,
			       LoginOk             => 0,
			       ModuleDir           => $lib::Config::CONFIG->{ModuleDir},
			       ModuleHandlesOutput => undef,
			       Modules             => $lib::Config::CONFIG->{Modules},
			       MyUrl               => undef,
			       Page                => lib::Page->new(),
			       ScriptName          => $ENV{SCRIPT_NAME},
			       Session             => undef,
			       SessionData         => $lib::Config::SESSION,
			       SessionId           => undef,
			       SystemLangs         => $lib::Config::SYSTEM_LANGS,
			       Tables              => $lib::Config::TABLES,
			       Template            => undef,
			       TmplData            => undef,
			       TmplDir             => $lib::Config::CONFIG->{TmplDir},
			       TmplFiles           => $lib::Config::TMPL,
			       UserData            => {
						       UserId      => undef,
						       UserLevel   => undef,
						       UserName    => undef,
						       UserPoints1 => undef,
						       UserPoints2 => undef
						       }
			      );

  my ($check, $class, $lang, $param);

  $param          = $self->{CGI}->param('action') || $self->{DefaultAction};
  $self->{Action} = $param;

  foreach my $module (@{$self->{Modules}}) {
    if ($param =~ /^$module->{action}\/?.*$/) {
      my $new_module = sprintf("%s/%s.pm", $self->{ModuleDir}, $module->{script});

      eval {
	require $new_module;
      };

      if ($@) {
	warn "Something is happend while loading: [$new_module].";
	warn "[Error:] $@";
	$self->fatal_error();
      }

      $param = $module->{script};
      $check = 1;
      last;
    }

    unless ($check) {
      $param = $self->{DefaultModule};
      require sprintf("%s/%s.pm", $self->{ModuleDir}, $self->{DefaultModule});
    }
  }

  eval {
    $class = sprintf("%s::%s", $self->{ModuleDir}, $param)->instance();
  };

  if ($@) {
    warn "Can't create class [$param].";
    warn "[Error:] $@";
    $self->fatal_error();
  }

  $self->set_lang();

  $self->check_login();

  if ($class->can("parameter")) {
    $self->check_session();

    eval {
      $class->parameter($self);
    };

    if ($@) {
      warn "Can't execute method parameter in class [$param].";
      warn "[Error:] $@";
      $self->fatal_error();
    }
  } else {
    warn "No parameter method in class [$class].";
    $self->fatal_error();
  }

  $self->output() unless $self->{ModuleHandlesOutput};
}

sub new {
  my ($class, %params) = @_;
	
  no strict 'refs';
  my $self = bless [\%{"$class\::FIELDS"}], $class;

  while (my ($key, $value) = each(%params)) {
    eval {
      $self->{$key} = $value;
    };

    if ($@) {
      if ($@ =~ /No such array field/i) {
	warn "Ignoring unknown key: [$key].";
	warn "[Error:] $@";
      }
    }
  }

  $self;
}

sub connect {
  my $self      = shift;
  my $db_string = sprintf("DBI:mysql:%s;host=%s;port=%s;",
			  $self->{DbData}->{DataBase},
			  $self->{DbData}->{DbHost},
			  $self->{DbData}->{DbPort}
			 );
	
  $self->{DbHandle} ||= DBI->connect(
				     $db_string,
				     $self->{DbData}->{DbUser},
				     $self->{DbData}->{DbPass},
				     {
				      RaiseError => 1
				     }
				    ) or $self->fatal_error("Can't connect to database.");
}

sub header {
  my $self = shift;

  print sprintf("Content-type: text/html; charset=%s\n\n", $self->{Charset});
}

sub to_unicode {
  my $self = shift;
  my $text = shift || '';
  my $tmp  = latin1($text);

  return $tmp->utf8();
}

sub set_lang {
  my $self = shift;

  if (defined $self->{CGI}->param('change_lang')) {
    my $lang = $self->{CGI}->param('system_langs') || 1;

    $self->{Language} = $lang;
  } else {
    my $lang = $self->{CGI}->param('lang') || 'de';

    foreach my $tmp (keys %{$self->{SystemLangs}}) {
      if ($lang eq $self->{SystemLangs}->{$tmp}) {
	$self->{Language} = $tmp;
      }
    }
  }
}

sub check_login {
  my $self = shift;

  unless ($self->check_session()) {
    if (defined $self->{CGI}->param('login')) {
      my $username = $self->{CGI}->param('login_username') || '';
      my $password = $self->{CGI}->param('login_password') || '';

      my $table = $self->{Tables}->{USER};

      my $dbh = $self->connect();
      my $sth = $dbh->prepare(<<SQL);

SELECT user_id, username, points, level, system_lang
FROM $table
WHERE username = ? AND password = ? AND status = '1'

SQL
      unless ($sth->execute($username, $password)) {
	warn sprintf("[Error:] Trouble selecting data from [%s].".
		     "Reason: [%s].", $table, $dbh->errstr());
        $self->fatal_error("Database error.");
      }

      my (@data) = $sth->fetchrow_array();
      $sth->finish();

      if (@data) {
	my $sid = $self->{Session}->start_session(UserId      => $data[0],
						  UserLevel   => $data[3],
						  UserName    => $data[1],
						  UserPoints1 => $data[2],
						  UserPoints2 => '');

	$self->{Language}  = $data[4];
	$self->{LoginOk}   = 1;
	$self->{SessionId} = $sid;

	$dbh->do("LOCK TABLES $table WRITE");
	$sth = $dbh->prepare(<<SQL);

UPDATE $table
SET last_login = ?
WHERE user_id = ?

SQL

        unless ($sth->execute(time(), $data[0])) {
	  warn sprintf("[Error:] Trouble selecting data from [%s].".
		       "Reason: [%s].", $table, $dbh->errstr());
	  $dbh->do("UNLOCK TABLES");
	  $self->fatal_error("Database error");
        }

	$dbh->do("UNLOCK TABLES");
	$sth->finish();
      } else {
	$self->{TmplData}{PAGE_LOGIN_ERROR} = 
	  $self->to_unicode($self->{Func}->get_text($self, 44));
      }
    }
  } else {
    if (defined $self->{CGI}->param('logout')) {
      $self->{Session}->kill_session($self->{SessionId});
      $self->{LoginOk}                 = 0;
      $self->{SessionId}               = undef;
      $self->{UserData}->{UserId}      = undef;
      $self->{UserData}->{UserLevel}   = undef;
      $self->{UserData}->{UserName}    = undef;
      $self->{UserData}->{UserPoints1} = undef;
      $self->{UserData}->{UserPoints2} = undef;
    }
  }
}

sub check_session {
  my $self = shift;
  my $sid  = $self->{CGI}->param('sid') || undef;

  $self->{Session} = lib::Session->new(ExpTime  => $self->{SessionData}->{ExpTime},
				       SessDir  => $self->{SessionData}->{SessDir},
				       SessFile => $self->{SessionData}->{SessFile},
				       Sid      => undef);

  $self->{Session}->check_sessions();

  if (defined $sid) {
    $self->{Session}->set_sid($sid);

    my $check;

    eval {
      $check = $self->{Session}->check_sid();
    };

    if ($@) {
      warn "[Error:] Trouble checking sessiond id [$sid].";
      $self->fatal_error();
    }

    if ($check) {
      $self->{LoginOk}                 = 1;
      $self->{SessionId}               = $sid;
      $self->{UserData}->{UserId}      = $self->{Session}->get("UserId");
      $self->{UserData}->{UserLevel}   = $self->{Session}->get("UserLevel");
      $self->{UserData}->{UserName}    = $self->{Session}->get("UserName");
      $self->{UserData}->{UserPoints1} = $self->{Session}->get("UserPoints1");
      $self->{UserData}->{UserPoints2} = $self->{Session}->get("UserPoints2");
      $self->{UserData}->{UserLevel}   = $self->{Session}->get("UserLevel");

      return 1;
    }
  }

  return undef;
}

sub fatal_error {
  my ($self, $error) = @_;

  $self->{Template}            = $self->{TmplFiles}->{Error};
  $self->{TmplData}            = undef;
  $self->{TmplData}{ERROR_TXT} = $self->to_unicode($error);

  warn "[Fatal Error:] $error" if $error;
  $self->output;
}

sub my_url {
  my $self = shift;

  return $self->{MyUrl} if $self->{MyUrl};

  my $lang = $self->{Language};

  $self->{MyUrl} = sprintf("%s?action=%s&lang=%s",
			   $self->{ScriptName},
			   $self->{Action},
			   $self->{SystemLangs}->{$lang}
			  );

  if ($self->{LoginOk} == 1) {
    $self->{MyUrl} .= sprintf("&sid=%s", $self->{SessionId});
  }

  return $self->{MyUrl};
}

sub output {
  my $self = shift;
  my $content;

  unless (-r $self->{TmplDir}."/".$self->{Template}) {
    warn "Template [$self->{Template}] not found in [$self->{TmplDir}].";

    if ($self->{Template} eq $self->{TmplFiles}->{Error}) {
      $self->template_error();
    } else {
      $self->fatal_error();
    }
  }

  my $template = HTML::Template->new(filename          => $self->{Template},
				     path              => $self->{TmplDir},
				     loop_context_vars => 1);

  $template->param(%{$self->{TmplData}});
  $self->header();

  print $template->output();
}

sub template_error {
  my $self  = shift;
  my $error = $self->to_unicode("Template parser error");

  $self->header();

  print qq{
	    <html>
	    <body>
	
	    <h1>$error</h1>

	    </body>
	    </html>
	   };

  exit;
}

1;
