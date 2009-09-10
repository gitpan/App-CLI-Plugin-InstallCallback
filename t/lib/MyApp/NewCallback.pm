package MyApp::NewCallback;

use strict;
use base qw(App::CLI::Command);

sub run {

    my($self, @args) = @_;
    $self->new_callback("test_callback1");
    $self->add_callback("test_callback1", \&test_callback1);
    $self->exec_callback("test_callback1");

    $self->new_callback("test_callback2");
    $self->add_callback("test_callback2", \&test_callback2);
    $self->exec_callback("test_callback2", "callback args");
}


sub test_callback1 {
    my($self, @args) = @_;
    $main::RESULT1 = "test_callback";
}

sub test_callback2 {
    my($self, @args) = @_;
    $main::RESULT2 = $args[0];
}

1;

