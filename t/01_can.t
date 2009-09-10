use strict;
use Test::More tests => 3;
use lib qw(t/lib);
use MyApp;

our %RESULT;

{
    local *ARGV = [qw(can)];
    MyApp->dispatch;
}

foreach my $check_method (qw(new_callback add_callback exec_callback)) {
    ok($RESULT{$check_method} == 1, "$check_method test");
}

