package lib::Page;

use strict;

sub new {
  my $proto = shift;
  my $class = ref($proto) || $proto;
  my $self  = {};

  bless ($self, $class);
}

sub fill_main_part {
  my ($self, $mgr) = @_;

  my $link = "%s?action=%s&lang=%s";
  $link   .= "&sid=".$mgr->{SessionId} if (defined $mgr->{SessionId});

  my $lang = $mgr->{Language};
  $lang    = $mgr->{SystemLangs}->{$lang};

  $mgr->{TmplData}{PAGE_SCRIPT}         = $mgr->{ScriptName};
  $mgr->{TmplData}{PAGE_CHARSET}        = $mgr->{Charset};
  $mgr->{TmplData}{PAGE_ACTION}         = $mgr->{Action};
  $mgr->{TmplData}{PAGE_SID}            = $mgr->{SessionId};
  $mgr->{TmplData}{PAGE_LANG}           = $lang;
  $mgr->{TmplData}{PAGE_OPEN}           = $mgr->{CGI}->param('open') || '';

  $mgr->{TmplData}{PAGE_LANG_000005}    = $mgr->{Func}->get_text($mgr, 5);
  $mgr->{TmplData}{PAGE_LANG_000006}    = $mgr->{Func}->get_text($mgr, 6);

  $mgr->{TmplData}{PAGE_LEFT_LINK_HOME} = $mgr->my_url(ACTION => "home");
}

sub fill_user_part {
  my ($self, $mgr, $user_type)    = @_;

  if ($mgr->{LoginOk} == 1) {
    my $lang    = $mgr->{Language};
    my $user_id = $mgr->{UserData}->{UserId}; 

    $mgr->{TmplData}{PAGE_LANG_000003} = $mgr->{Func}->get_text($mgr, 3);
    $mgr->{TmplData}{PAGE_LANG_000008} = $mgr->{Func}->get_text($mgr, 8);
    $mgr->{TmplData}{PAGE_LANG_000009} = $mgr->{Func}->get_text($mgr, 9);
    $mgr->{TmplData}{PAGE_LANG_000010} = $mgr->{Func}->get_text($mgr, 10);
    $mgr->{TmplData}{PAGE_LANG_000011} = $mgr->{Func}->get_text($mgr, 11);
    $mgr->{TmplData}{PAGE_USER_LINK}   = $mgr->my_url(ACTION => "user", METHOD => "mypage");

    $mgr->{TmplData}{PAGE_USERNAME}   = 
      $mgr->to_unicode($mgr->{UserData}->{UserName});
    $mgr->{TmplData}{PAGE_ALL_POINTS} = 
      $mgr->{Points}->get_activ_points($mgr, $user_id);
    $mgr->{TmplData}{PAGE_POINTS}     = 
      $mgr->{Points}->get_inactiv_points($mgr, $user_id);

    if (defined $mgr->{UserData}->{UserLevel}) {
      if ($mgr->{UserData}->{UserLevel} == 2) {
	$mgr->{TmplData}{PAGE_USER_TYPE_2}    = 1;
	$mgr->{TmplData}{PAGE_CATEGORY_ADMIN} = $mgr->my_url(ACTION => "home", 
							     METHOD => "cat_admin",
							     MODE   => "admin");
	$mgr->{TmplData}{PAGE_LANG_000014}    = $mgr->{Func}->get_text($mgr, 14);
      } elsif ($mgr->{UserData}->{UserLevel} == 1) {

      } else {

      }
    }

  } else {
    $mgr->{TmplData}{PAGE_REGISTER_LINK} = $mgr->my_url(ACTION => "user", METHOD => "reg1");
    $mgr->{TmplData}{PAGE_LEFT_REGISTER} = $mgr->{Func}->get_text($mgr, 23);
    $mgr->{TmplData}{PAGE_IF_LOGIN}      = 1;
    $mgr->{TmplData}{PAGE_LANG_000003}   = $mgr->{Func}->get_text($mgr, 3);
    $mgr->{TmplData}{PAGE_LANG_000004}   = $mgr->{Func}->get_text($mgr, 4);
    $mgr->{TmplData}{PAGE_LANG_000007}   = $mgr->{Func}->get_text($mgr, 7);
  }

}

sub fill_lang_part {
  my ($self, $mgr) = @_;

  my @langs   = $mgr->{Func}->get_langs($mgr, "system");
  my $count   = 0;
  my @page_system_lang;

  foreach my $lang (@langs) {
    $page_system_lang[$count]{PAGE_SYSTEM_LANG_ID}   = $lang->[0];
    $page_system_lang[$count]{PAGE_SYSTEM_LANG_NAME} = $lang->[1];

    $count++;
  }

  $mgr->{TmplData}{PAGE_LOOP_SYSTEM_LANG} = \@page_system_lang;
}

1;
