#!perl

use strict;
use warnings;

use Test::More;
use Test::Exception;

plan tests => 9;

my $good_file = 'samples/IP-COUNTRY-SAMPLE.BIN';

if ( ! -f $good_file ) {
	BAIL_OUT( "no IP2Location binary data file found" );
}

use_ok( 'Geo::IP2Location::Lite' );

throws_ok(
	sub { Geo::IP2Location::Lite->open },
	qr/\Qopen() requires a database path name\E/,
	'open with no arg throws',
);

throws_ok(
	sub { Geo::IP2Location::Lite->open( 'bad_file_path' ) },
	qr/\Qerror opening bad_file_path: No such file\E/,
	'open with bad file throws',
);

isa_ok(
	my $obj = Geo::IP2Location::Lite->open( $good_file ),
	'Geo::IP2Location::Lite'
);

is( $obj->get_country_short,'INVALID IP ADDRESS',"lookup with no arg" );
is( $obj->get_country_short( 'foo' ),'INVALID IP ADDRESS',"lookup with bad IP" );
is( $obj->get_country_short( '0.0.3.4' ),'-',"lookup with missing IP" );
is( $obj->get_country_short( '255.255.255.254' ),'??',"lookup with not covered IP" );

is(
	$obj->get_latitude( '0.0.3.4' ),
	'This parameter is unavailable in selected .BIN data file. Please upgrade data file.',
	'data unsupported function'
);
