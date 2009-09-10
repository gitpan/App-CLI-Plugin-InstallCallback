package MyApp::Plugin::Postrun1;

sub setup {

    my $self = shift;
    $self->add_callback("postrun", sub { $main::RESULT{postrun1} = 1 });
    return $self->NEXT::setup;
}

1;
