use strict;
use Test::More tests => 2;
use lib qw(t/lib);
use MyApp;

our $RESULT1;
our $RESULT2;

{
    local *ARGV = [qw(newcallback)];
    MyApp->dispatch;
}

ok($RESULT1 eq "test_callback");
ok($RESULT2 eq "callback args");

