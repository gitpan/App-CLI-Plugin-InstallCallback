package App::CLI::Plugin::InstallCallback;

=pod

=head1 NAME

App::CLI::Plugin::InstallCallback - for App::CLI::Extension install callback module

=head1 VERSION

0.2

=head1 SYNOPSIS
  
  # MyApp.pm
  package MyApp;
  
  use strict;
  use base qw(App::CLI::Extension);
  
  __PACKAGE__->load_plugins(qw(InstallCallback));
  
  # MyApp/Hello.pm
  package MyApp::Hello;
  use strict;
  use feature ":5.10.0";
  use base qw(App::CLI::Command);
  
  sub prerun {
  
      my($self, @args) = @_;
      say "prerun method!";
  }
  
  sub run {
  
      my($self, @args) = @_;
      say "run method!";
  }
  
  sub postrun {
  
      my($self, @args) = @_;
      say "postrun method!";
  }
  
  sub finish {
  
      my($self, @args) = @_;
      say "finish method!";
  }
  
  # myapp
  #!/usr/bin/perl
  
  use strict;
  use MyApp;
  
  MyApp->dispatch;
  
  # execute
  [kurt@localhost ~] myapp hello
  prerun method!
  run method!
  postrun method!
  finish method!

=head1 DESCRIPTION

App::CLI::Extension install callback module

In App::CLI, run set of non-execution method, perform the installation

  prerun phase(if exists) -> run phase -> postrun phase(if exists) -> finish phase(if exists)

App::CLI::Command in a class that inherits the *prerun*, *postrun*, *finish* the run only if it defines a method

=cut

use strict;
use 5.008;
use base qw(Class::Data::Accessor);
use Sub::Install;
use NEXT;

__PACKAGE__->mk_classaccessor( "_install_callback" );
our $VERSION  = '0.2';
our @DEFAULT_CALLBACK = qw(prerun postrun finish);

sub setup {

    my $self = shift;

    $self->_install_callback({ map { $_ => [] } @DEFAULT_CALLBACK });
    Sub::Install::reinstall_sub({
                          code => \&_run_command,
                          into => ref($self),
                          as   => "run_command",     
                        });
    return $self->NEXT::setup;
}

=pod

=head1 METHOD

=head2 new_callback

install new callback phase

Example:

  $self->new_callback("some_phase");

=cut

sub new_callback {

    my($self, $install, $callback) = @_;
    die "already exists $install" if exists $self->_install_callback->{$install};
    $self->_install_callback->{$install} = [];
    $self->add_callback($install, $callback) if defined $callback;
}

=pod

=head2 add_callback

install new callback

Example:

  $self->add_callback("some_phase", sub { my $self = shift; say "some_phase method" });
  $self->add_callback("prerun", sub { my $self = shift; say "prerun method No.1" });
  $self->add_callback("prerun", sub { my $self = shift; say "prerun method No.2" });

=cut

sub add_callback {

    my($self, $install, $callback) = @_;
    die "non install callback: $install" if !exists $self->_install_callback->{$install};
    die "\$callback is not CODE" if ref($callback) ne "CODE";

    push @{$self->_install_callback->{$install}}, $callback;
}

=pod

=head2 exec_callback

execute callback

Example:

  $self->execute_callback("some_phase");
  # some_phase method
  
  $self->execute_callback("prerun");
  # prerun method No.1
  # prerun method No.2

=cut
sub exec_callback {

    my($self, $install, @args) = @_;
    die "non install callback: $install" if !exists $self->_install_callback->{$install};

    my @install_callback = @{$self->_install_callback->{$install}};
    if (my $coderef = $self->can($install)) {
        push @install_callback, $coderef;
    }
    map { $self->$_(@args) } @install_callback;
}

##############################################
# App::CLI::Command override run_command method
##############################################
sub _run_command {

    my($self, @args) = @_;
    $self->exec_callback("prerun",  @args);
    $self->run(@args);
    $self->exec_callback("postrun", @args);
    $self->exec_callback("finish",  @args);
}
1;

__END__

=head1 SEE ALSO

L<App::CLI::Extension> L<Class::Data::Accessor> L<Sub::Install>

=head1 AUTHOR

Akira Horimoto

=head1 COPYRIGHT AND LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

Copyright (C) 2009 Akira Horimoto

=cut

