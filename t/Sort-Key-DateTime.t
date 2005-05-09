# -*- Mode: Perl -*-
# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl DateTime-Sort-Key.t'

use Test::More tests => 5;
BEGIN { use_ok('Sort::Key::DateTime') };

use DateTime;
use Sort::Key::DateTime qw(dtkeysort);

my @tz=qw(UTC Europe/Madrid Asia/Taipei America/Los_Angeles);

for (10, 100, 1000, 5000) {
    my @unsorted = map { DateTime->new( year => 1900+int rand(20),
					month => 1+int rand(12),
					day => 1+int rand(28),
					hour => int rand(24),
					minute => int rand(60),
					second => int rand(60),
					time_zone => $tz[int rand(@tz)] ) } 0..$_;

    is_deeply([dtkeysort { $_ } @unsorted], [sort @unsorted], "sorting $_");
}
