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

  $mgr->{TmplData}{PAGE_SCRIPT}      = $mgr->{ScriptName};
  $mgr->{TmplData}{PAGE_CHARSET}     = $mgr->{Charset};
  $mgr->{TmplData}{PAGE_ACTION}      = $mgr->{Action};
  $mgr->{TmplData}{PAGE_SID}         = $mgr->{SessionId};
  $mgr->{TmplData}{PAGE_LANG}        = $lang;

  $mgr->{TmplData}{PAGE_LANG_000001} = $mgr->{Func}->get_text($mgr, 5);
  $mgr->{TmplData}{PAGE_LANG_000002} = $mgr->{Func}->get_text($mgr, 6);

  $mgr->{TmplData}{PAGE_LEFT_LINK_HOME} = sprintf($link,
						  $mgr->{ScriptName},
						  "home",
						  $lang);
}

sub fill_user_part {
  my ($self, $mgr, $user_type)    = @_;

  if ($mgr->{LoginOk} == 1) {
    my $lang = $mgr->{Language};

    $mgr->{TmplData}{PAGE_LANG_000008} = $mgr->{Func}->get_text($mgr, 3);
    $mgr->{TmplData}{PAGE_LANG_000006} = $mgr->{Func}->get_text($mgr, 8);
    $mgr->{TmplData}{PAGE_LANG_000007} = $mgr->{Func}->get_text($mgr, 9);
    $mgr->{TmplData}{PAGE_LANG_000009} = $mgr->{Func}->get_text($mgr, 10);
    $mgr->{TmplData}{PAGE_LANG_000010} = $mgr->{Func}->get_text($mgr, 11);
    $mgr->{TmplData}{PAGE_USER_LINK}   =
      sprintf("%s?action=%s&lang=%s&sid=%s",
	      $mgr->{ScriptName}, "user",
	      $mgr->{SystemLangs}->{$lang},
	      $mgr->{SessionId});
    $mgr->{TmplData}{PAGE_LANG_000012} = $mgr->{Func}->get_text($mgr, 13);
    $mgr->{TmplData}{PAGE_TEXT_LINK}   =
      sprintf("%s?action=%s&lang=%s&sid=%s",
	      $mgr->{ScriptName}, "text",
	      $mgr->{SystemLangs}->{$lang},
	      $mgr->{SessionId});

    $mgr->{TmplData}{PAGE_USERNAME}   = 
      $mgr->to_unicode($mgr->{UserData}->{UserName});
    $mgr->{TmplData}{PAGE_ALL_POINTS} = 
      $mgr->to_unicode($mgr->{Session}->get("UserPoints1") || '0');
    $mgr->{TmplData}{PAGE_POINTS}     = 
      $mgr->to_unicode($mgr->{Session}->get("UserPoints2") || '0');

    if (defined $mgr->{UserData}->{UserLevel}) {
      if ($mgr->{UserData}->{UserLevel} == 2) {
	$mgr->{TmplData}{PAGE_USER_TYPE_2}    = 1;
	$mgr->{TmplData}{PAGE_CATEGORY_ADMIN} = sprintf("%s&method=cat_admin", $mgr->my_url());
	$mgr->{TmplData}{PAGE_LANG_000011}    = $mgr->{Func}->get_text($mgr, 14);
      } elsif ($mgr->{UserData}->{UserLevel} == 1) {

      } else {

      }
    }

  } else {
    $mgr->{TmplData}{PAGE_IF_LOGIN}    = 1;
    $mgr->{TmplData}{PAGE_LANG_000003} = $mgr->{Func}->get_text($mgr, 3);
    $mgr->{TmplData}{PAGE_LANG_000004} = $mgr->{Func}->get_text($mgr, 4);
    $mgr->{TmplData}{PAGE_LANG_000005} = $mgr->{Func}->get_text($mgr, 7);
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
