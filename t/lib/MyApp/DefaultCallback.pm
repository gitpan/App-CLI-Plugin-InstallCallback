package MyApp::DefaultCallback;

use strict;
use base qw(App::CLI::Command);

sub prerun {

    my($self, @args) = @_;
    $main::RESULT{prerun} = 1;
}

sub run {

    my($self, @args) = @_;
    $main::RESULT{run} = 1;
}


sub postrun {
    my($self, @args) = @_;
    $main::RESULT{postrun} = 1;
}

sub finish {
    my($self, @args) = @_;
    $main::RESULT{finish} = 1;
}

1;

