package lib::Session;

use Digest::MD5;
use Fcntl;
use File::Path;
use Storable qw(nfreeze thaw);
use Symbol;
use vars qw($VERSION);
use strict;

sub new {
    my $proto  = shift;
    my %params = @_;

    my $class = ref($proto) || $proto;
    my $self;

    $self->{directory}  = $params{directory};
    $self->{exp_time}   = $params{exp_time};
    
    $self->{_main}->{file} = Symbol::gensym();
    $self->{_main}->{name} = $params{file};

    $self->{_sess}->{file} = Symbol::gensym();

    $self->{_open} = 0;
    
    eval {
        sysopen($self->{_main}->{file}, $self->{directory}."/".$self->{_main}->{name}, O_RDWR|O_CREAT);
        $self->{_open} = 1;
    };
        
    my $file = $self->{_main}->{file};

    while (<$file>) {
        $self->{_main}->{serialized} .= $_;
    }

    $self->{_main}->{unserialized} = thaw ($self->{_main}->{serialized});

    return bless ($self, $class);
}

sub start_session {
    my $self   = shift;
    my %params = @_;

    my $sid                              = $self->_create_sid();
    $self->{_main}->{unserialized}{$sid} = $self->_get_expires();
    $self->{_sess}->{name}               = $sid;
    
    eval {
        sysopen($self->{_sess}->{file}, $self->{directory}."/".$self->{_sess}->{name}, O_RDWR|O_CREAT);
        $self->{_open} = 2;
    };

    $self->set(%params);

    return $sid;
}

sub kill_session {
    my $self = shift;
    my $sid  = shift || undef;

    $sid = $self->{_sess}->{name} unless ($sid);

    if ($self->{_open} == 2) {
        CORE::close $self->{_sess}->{file};
        $self->{_open} -= 1;
    }
    
    eval {
        rmtree([$self->{directory}."/".$self->{_sess}->{name}], 0, 0);
    };

    delete $self->{_sess};
    delete $self->{_main}->{unserialized}{$sid};
}

sub check_sid {
    my $self = shift;
    my $sid  = shift || undef;

    $self->{_sess}->{name} = $sid if (defined $sid);

    return undef unless (defined $self->{_sess}->{name});

    foreach (keys %{$self->{_main}->{unserialized}}) {
        if ($_ eq $sid) {
            return 1;
        }
    }

    return undef;
}

sub set {
    my $self   = shift;
    my %params = @_;

    foreach (keys %params) {
        next unless (defined $params{$_});
        $self->{_sess}->{unserialized}{$_} = $params{$_};
    }
}

sub get {
    my $self = shift;
    my $key  = shift;

    return $self->{_sess}->{unserialized}{$key};
}

sub del {
    my $self = shift;
    my $key  = shift;

    delete $self->{_sess}->{unserialized}{$key};
}

sub set_sid {
    my $self = shift;
    my $sid  = shift;

    $self->{_sess}->{name} = $sid;

    eval {
        sysopen($self->{_sess}->{file}, $self->{directory}."/".$self->{_sess}->{name}, O_RDWR|O_CREAT);
        $self->{_open} = 2;

        my $file = $self->{_sess}->{file};

        while (<$file>) {
            $self->{_sess}->{serialized} .= $_;
        }

        $self->{_sess}->{unserialized} = $self->unserialize($self->{_sess}->{serialized});
    };
}

sub get_sid {
    my $self = shift;

    return $self->{_sess}->{name};
}

sub check_sessions {
    my $self = shift;

    my $time = time();

    foreach (keys %{$self->{_main}->{unserialized}}) {
        if ($self->{_main}->{unserialized}{$_} < $time) {
             eval {
                rmtree([$self->{directory}."/".$_], 0, 0);
		delete $self->{_main}->{unserialized}{$_};
             };
        }
    }
}

sub _create_sid {
    my $self = shift;

    my $ctx  = Digest::MD5->new();
    my $data = "";

    for (my $i = 0; $i < 20; $i++) {
        $data .= join('', (0..9, 'A'..'Z', 'a'..'z')[rand 62, rand 62, rand 62, rand 62]);
    }

    $ctx->add($data);

    return $ctx->hexdigest();
}

sub _get_expires {
    my $self = shift;

    return ($self->{exp_time} + time());
}

sub serialize {
    my $self         = shift;
    my $unserialized = shift;

    return (nfreeze $unserialized) if ($unserialized);
}

sub unserialize {
    my $self       = shift;
    my $serialized = shift;

    return (thaw $serialized) if ($serialized);
}

sub DESTROY {
    my $self = shift;

    if ($self->{_open} == 2) {
        eval {
            $self->{_sess}->{serialized} = $self->serialize($self->{_sess}->{unserialized});

            truncate($self->{_sess}->{file}, 0);
            seek($self->{_sess}->{file}, 0, 0);

            print {$self->{_sess}->{file}} $self->{_sess}->{serialized} if($self->{_sess}->{serialized});

            CORE::close $self->{_sess}->{file};

            if (!defined $self->{_main}->{unserialized}{$self->{_sess}->{name}}) {
                if (defined $self->{_sess}->{name} && $self->{_sess}->{name} ne "") {
                    rmtree([$self->{directory}."/".$self->{_sess}->{name}], 0, 0);
                }
            }
        };
    }

    eval {
        $self->{_main}->{serialized} = $self->serialize($self->{_main}->{unserialized});

        truncate($self->{_main}->{file}, 0);
        seek($self->{_main}->{file}, 0, 0);
        
        print {$self->{_main}->{file}} $self->{_main}->{serialized};
        
        CORE::close $self->{_main}->{file};
    };
}

1;
