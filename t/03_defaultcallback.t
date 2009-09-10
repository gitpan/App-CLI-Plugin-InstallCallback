use strict;
use Test::More tests => 4;
use lib qw(t/lib);
use MyApp;

our %RESULT;

{
    local *ARGV = [qw(default)];
    MyApp->dispatch;
}

foreach my $default_method (qw(prerun run postrun finish)) {
    ok($RESULT{$default_method} == 1);
}

