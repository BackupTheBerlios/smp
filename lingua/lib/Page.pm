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

    # languages
    $mgr->{TmplData}{PAGE_LANG_000501}    = $mgr->{Func}->get_text($mgr, 501);
    $mgr->{TmplData}{PAGE_LANG_000502}    = $mgr->{Func}->get_text($mgr, 502);

    # navigation
    $mgr->{TmplData}{PAGE_LANG_000503}    = $mgr->{Func}->get_text($mgr, 503);
    $mgr->{TmplData}{PAGE_LANG_000504}    = $mgr->{Func}->get_text($mgr, 504);
    $mgr->{TmplData}{PAGE_LANG_000508}    = $mgr->{Func}->get_text($mgr, 508);
    $mgr->{TmplData}{PAGE_LANG_000509}    = $mgr->{Func}->get_text($mgr, 509);

    $mgr->{TmplData}{PAGE_LEFT_LINK_HOME} = $mgr->my_url(ACTION => "home");
    $mgr->{TmplData}{PAGE_LEFT_LINK_HELP} = $mgr->my_url(ACTION => "help") . "&index=1";
    $mgr->{TmplData}{PAGE_LEFT_LINK_CONT} = $mgr->my_url(ACTION => "help") . "&index=12";

    # serach
    $mgr->{TmplData}{PAGE_LANG_000510}    = $mgr->{Func}->get_text($mgr, 510);
    $mgr->{TmplData}{PAGE_LANG_000511}    = $mgr->{Func}->get_text($mgr, 511);
    $mgr->{TmplData}{PAGE_LANG_000512}    = $mgr->{Func}->get_text($mgr, 512);
    $mgr->{TmplData}{PAGE_LANG_000513}    = $mgr->{Func}->get_text($mgr, 513);
}

sub fill_user_part {
  my ($self, $mgr, $user_type)    = @_;

  if ($mgr->{LoginOk} == 1) {
    my $lang    = $mgr->{Language};
    my $user_id = $mgr->{UserData}->{UserId}; 

    # user area
    $mgr->{TmplData}{PAGE_LANG_000520} = $mgr->{Func}->get_text($mgr, 520); # header
    $mgr->{TmplData}{PAGE_LANG_000516} = $mgr->{Func}->get_text($mgr, 516); # 'username'
    $mgr->{TmplData}{PAGE_LANG_000521} = $mgr->{Func}->get_text($mgr, 521); # points 1
    $mgr->{TmplData}{PAGE_LANG_000522} = $mgr->{Func}->get_text($mgr, 522); # points 2
    $mgr->{TmplData}{PAGE_LANG_000523} = $mgr->{Func}->get_text($mgr, 523); # logout button

    $mgr->{TmplData}{PAGE_USERNAME}   = 
      $mgr->to_unicode($mgr->{UserData}->{UserName});
    $mgr->{TmplData}{PAGE_ALL_POINTS} = 
      $mgr->{Points}->get_activ_points($mgr, $user_id);
    $mgr->{TmplData}{PAGE_POINTS}     = 
      $mgr->{Points}->get_inactiv_points($mgr, $user_id);

    # personal page link
    $mgr->{TmplData}{PAGE_LANG_000505} = $mgr->{Func}->get_text($mgr, 505); 
    $mgr->{TmplData}{PAGE_LEFT_LINK_PERS}   = $mgr->my_url(ACTION => "user", METHOD => "mypage");


    if (defined $mgr->{UserData}->{UserLevel}) {
      if ($mgr->{UserData}->{UserLevel} == 2) {
	$mgr->{TmplData}{PAGE_USER_TYPE_2}     = 1;
	$mgr->{TmplData}{PAGE_LANG_000506}     = $mgr->{Func}->get_text($mgr, 506);
	$mgr->{TmplData}{PAGE_LANG_000507}     = $mgr->{Func}->get_text($mgr, 507);
	$mgr->{TmplData}{PAGE_LEFT_LINK_CAT}  = $mgr->my_url(ACTION => "home", 
							      METHOD => "cat_admin",
							      MODE   => "admin");
	$mgr->{TmplData}{PAGE_LEFT_LINK_ADM} = $mgr->my_url(ACTION => "user",
							      METHOD => "adm_search");
      } elsif ($mgr->{UserData}->{UserLevel} == 1) {

      } else {

      }
    }

  } else {
    # login area
    $mgr->{TmplData}{PAGE_IF_LOGIN}      = 1;
    $mgr->{TmplData}{PAGE_LANG_000514}   = $mgr->{Func}->get_text($mgr, 514);
    $mgr->{TmplData}{PAGE_LANG_000515}   = $mgr->{Func}->get_text($mgr, 515);
    $mgr->{TmplData}{PAGE_REGISTER_LINK} = $mgr->my_url(ACTION => "user", METHOD => "reg1");
    $mgr->{TmplData}{PAGE_LANG_000516}   = $mgr->{Func}->get_text($mgr, 516);
    $mgr->{TmplData}{PAGE_LANG_000517}   = $mgr->{Func}->get_text($mgr, 517);
    $mgr->{TmplData}{PAGE_LANG_000518}   = $mgr->{Func}->get_text($mgr, 518);
  }

}

sub fill_lang_part {
  my ($self, $mgr) = @_;

  my @langs   = $mgr->{Func}->get_langs($mgr, "system");
  my $count   = 0;
  my @page_system_lang;

  foreach my $lang (@langs) {
    if ($lang->[0] == $mgr->{Language}) {
      $page_system_lang[$count]{PAGE_IF_SYSTEM_LANG} = 1;
    }

    $page_system_lang[$count]{PAGE_SYSTEM_LANG_ID}   = $lang->[0];
    $page_system_lang[$count]{PAGE_SYSTEM_LANG_NAME} = $lang->[1];

    $count++;
  }

  $mgr->{TmplData}{PAGE_LOOP_SYSTEM_LANG} = \@page_system_lang;
}

1;
