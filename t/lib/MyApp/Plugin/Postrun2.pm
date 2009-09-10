package MyApp::Plugin::Postrun2;

sub setup {

    my $self = shift;
    $self->add_callback("postrun", sub { $main::RESULT{postrun2} = 1 });
    return $self->NEXT::setup;
}

1;
