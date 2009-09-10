use strict;
use Test::More tests => 6;
use lib qw(t/lib);
use MyApp;

our %RESULT;

{
    local *ARGV = [qw(same)];
    MyApp->dispatch;
}

foreach my $check_method (qw(prerun1 prerun2 postrun1 postrun2 finish1 finish2)) {
    ok($RESULT{$check_method} == 1);
}

