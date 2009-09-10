package MyApp::Plugin::Finish1;

sub setup {

    my $self = shift;
    $self->add_callback("finish", sub { $main::RESULT{finish1} = 1 });
    return $self->NEXT::setup;
}

1;
