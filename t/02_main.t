#!/usr/bin/perl -w

# Load test the Email::Send::Test module

use strict;
use lib ();
use UNIVERSAL 'isa';
use File::Spec::Functions ':ALL';
BEGIN {
	$| = 1;
	unless ( $ENV{HARNESS_ACTIVE} ) {
		require FindBin;
		chdir ($FindBin::Bin = $FindBin::Bin); # Avoid a warning
		lib->import( catdir( updir(), updir(), 'modules') );
	}
}





# Does everything load?
use Test::More 'tests' => 7;
use Email::Send 'Test';

send Test => 'foo';

is( scalar(Email::Send::Test->emails), 1, 'Sending an email results in something in the trap' );
my @emails = Email::Send::Test->emails;
isa_ok( $emails[0], 'Email::Simple');
ok( Email::Send::Test::send( undef ), 'Sending anything returns true' );
is( scalar(Email::Send::Test->emails), 2, 'Sending an email results in something in the trap' );
is( (Email::Send::Test->emails)[1], undef, 'Sending an emails puts what we send in the trap' );
ok( Email::Send::Test->clear, '->clear returns true' );
is( scalar(Email::Send::Test->emails), 0, '->clear clears the trap' );

1;
