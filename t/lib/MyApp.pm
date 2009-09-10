package MyApp;

use strict;
use base qw(App::CLI::Extension);
use constant alias => (
                 newcallback => "NewCallback",
                 default     => "DefaultCallback",
                 same        => "SameInstallCallback",
             );

__PACKAGE__->load_plugins(qw(
              InstallCallback 
             +MyApp::Plugin::Prerun1
             +MyApp::Plugin::Prerun2
             +MyApp::Plugin::Postrun1
             +MyApp::Plugin::Postrun2
             +MyApp::Plugin::Finish1
             +MyApp::Plugin::Finish2
            ));

1;

