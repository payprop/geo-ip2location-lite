#!perl

use strict;
use warnings;

use Test::More;

my $file = 'samples/IP-COUNTRY-SAMPLE.BIN';

if ( ! -f $file ) {
	BAIL_OUT( "no IP2Location binary data file found" );
}

plan tests => 14;

use_ok( 'Geo::IP2Location::Lite' );

isa_ok(
	my $obj = Geo::IP2Location::Lite->open( $file ),
	'Geo::IP2Location::Lite'
);

while (<DATA>) {
	chomp;
	my ( $ipaddr,$exp_country ) = split( "\t" );
	my $country = $obj->get_country_short( $ipaddr );
	is( uc( $country ),$exp_country,"get_country_short ($country)" );
}

is( $obj->get_module_version,$Geo::IP2Location::Lite::VERSION,'get_module_version' );
is( $obj->get_database_version,'5.6.17','get_database_version' );

__DATA__
19.5.10.1	US
25.5.10.2	GB
43.5.10.3	JP
47.5.10.4	CA
51.5.10.5	GB
53.5.10.6	DE
80.5.10.7	GB
81.5.10.8	IL
83.5.10.9	PL
85.5.10.0	CH
