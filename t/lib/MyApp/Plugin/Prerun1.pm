package MyApp::Plugin::Prerun1;

sub setup {

    my $self = shift;
    $self->add_callback("prerun", sub { $main::RESULT{prerun1} = 1 });
    return $self->NEXT::setup;
}

1;
