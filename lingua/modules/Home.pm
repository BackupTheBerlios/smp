package modules::Home;

use Class::Singleton;
use base 'Class::Singleton';
use vars qw($VERSION);
use strict;

$VERSION = sprintf "%d.%03d", q$Revision: 1.12 $ =~ /(\d+)\.(\d+)/;

#-----------------------------------------------------------------------------#
# CALL:   $self->parameter($mgr).                                             #
#                                                                             #
#         $mgr = manager object.                                              #
#                                                                             #
# AUTHOR: Sören Wurch (sowuinfo@cs.tu-berlin.de)                              #
#                                                                             #
# DESC:   Main function for the Home module.                                  #
#                                                                             #
# RETURN: none.                                                               #
#-----------------------------------------------------------------------------#
sub parameter {
  my ($self, $mgr) = @_;

  my $method = $mgr->{CGI}->param('method') || '';

  if ($method eq "cat_admin") {
    $self->show_tree($mgr);
  } elsif ($method eq "show_cat") {
    $self->show_tree($mgr);
  } elsif ($method eq "cat_open") {
    $mgr->{Tree}->open_tree($mgr);
    $self->show_tree($mgr);
  } elsif ($method eq "cat_close") {
    $mgr->{Tree}->close_tree($mgr);
    $self->show_tree($mgr);
  } else {
    $self->show_tree($mgr);
  }

  $mgr->{TmplData}{PAGE_CAT_ID} = $mgr->{CGI}->param('cat_id') || '';
}

#-----------------------------------------------------------------------------#
# CALL:   $self->show_tree($mgr).                                             #
#                                                                             #
#         $mgr = manager object.                                              #
#                                                                             #
# DESC:   Creates a tree with all the categories.                             #
#                                                                             #
# RETURN: none.                                                               #
#-----------------------------------------------------------------------------#
sub show_tree {
  my ($self, $mgr) = @_;

  my $mode = $mgr->{CGI}->param('mode') || '';

  if ($mode eq "admin") {
    unless ($mgr->{Func}->check_for_user($mgr, 2)) {
      $mode = "";
    }
  }

  my $cat_id = $mgr->{CGI}->param('cat_id') || "0";
  my $count  = 0;
  my (%list, @result, @open);

  if ($mode eq "admin") {
    @open = split (',', $mgr->{Session}->get("AdminCatsOpen") || '');
    $mgr->{TmplData}{PAGE_CAT_ADMIN}   = 1;
    $mgr->{TmplData}{PAGE_LANG_000015} = $mgr->{Func}->get_text($mgr, 15);
  } else {
    @open = split (',', $mgr->{CGI}->param('open') || '');
  }

  # Get all the ids, which are open.
  foreach my $open (@open) {
    $list{$open} = 1;
  }

  $mgr->{Template}  = $mgr->{TmplFiles}->{Home_Tree};
  ($count, @result) = $mgr->{Tree}->create_tree($mgr, $cat_id, \%list, $count, \@result, $mode);

  $mgr->{TmplData}{PAGE_LOOP_CATS} = \@result;
}

sub show_text_data {
  my ($self, $mgr, $cat_id) = @_;

  my $page  = $mgr->{CGI}->param('page')   || 0;
  my @data  = $mgr->{Func}->get_original_texts($mgr, $cat_id);
  my $count = 0;
  my @result;

  foreach my $tmp (@data) {
    $result[$count]{PAGE_TEXT_TITLE} = @$tmp[1];
    $count++;
  }

  return \@result;
}

sub fill_text_header {
  my ($self, $mgr) = @_;

  $mgr->{TmplData}{PAGE_LANG_000024} = $mgr->{Func}->get_text($mgr, 24);
  $mgr->{TmplData}{PAGE_LANG_000025} = $mgr->{Func}->get_text($mgr, 25);
  $mgr->{TmplData}{PAGE_LANG_000026} = $mgr->{Func}->get_text($mgr, 26);
  $mgr->{TmplData}{PAGE_LANG_000027} = $mgr->{Func}->get_text($mgr, 27);
}

1;
