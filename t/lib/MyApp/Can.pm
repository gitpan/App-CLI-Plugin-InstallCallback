package MyApp::Can;

use strict;
use base qw(App::CLI::Command);

sub run {

    my($self, @args) = @_;
    foreach my $check_method (qw(new_callback add_callback exec_callback)) {
        $main::RESULT{$check_method} = ($self->can($check_method)) ? 1 : 0;
    }
}

1;

