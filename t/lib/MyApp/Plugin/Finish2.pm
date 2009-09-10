package MyApp::Plugin::Finish2;

sub setup {

    my $self = shift;
    $self->add_callback("finish", sub { $main::RESULT{finish2} = 1 });
    return $self->NEXT::setup;
}

1;
