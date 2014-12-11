#!perl

use strict;
use warnings;

use Test::More;
use Test::Deep;

my $file = 'samples/IP-COUNTRY-REGION-CITY-LATITUDE-LONGITUDE-ZIPCODE-TIMEZONE-ISP-DOMAIN-NETSPEED-AREACODE-WEATHER-MOBILE-ELEVATION-USAGETYPE-SAMPLE.BIN';

if ( ! -f $file ) {
	plan skip_all => "get DB24 sample file from ip2location.com to run this test";
} else {
	plan tests => 23;
}

use_ok( 'Geo::IP2Location::Lite' );

my $obj = Geo::IP2Location::Lite->open( $file );
my $ip  = '85.5.10.0';

my $country = $obj->get_country_short( $ip );

cmp_deeply( [ $obj->get_country( $ip ) ],[ 'CH','SWITZERLAND' ],'get_country' );
is( $obj->get_country_short( $ip ),'CH','get_country_short' );
is( $obj->get_country_long( $ip ),'SWITZERLAND','get_country_long' );
is( $obj->get_region( $ip ),'ZURICH','get_region' );
is( $obj->get_city( $ip ),'ZURICH','get_city' );
is( $obj->get_isp( $ip ),'BLUEWIN IS AN LIR AND ISP IN SWITZERLAND.','get_isp' );
is( $obj->get_latitude( $ip ),'47.366669','get_latitude' );
is( $obj->get_zipcode( $ip ),'8045','get_zipcode' );
is( $obj->get_longitude( $ip ),'8.550000','get_longitude' );
is( $obj->get_domain( $ip ),'BLUEWIN.CH','get_domain' );
is( $obj->get_timezone( $ip ),'+02:00','get_timezone' );
is( $obj->get_netspeed( $ip ),'DSL','get_netspeed' );
is( $obj->get_iddcode( $ip ),'41','get_iddcode' );
is( $obj->get_areacode( $ip ),'044','get_areacode' );
is( $obj->get_weatherstationcode( $ip ),'SZXX0033','get_weatherstationcode' );
is( $obj->get_weatherstationname( $ip ),'ZURICH','get_weatherstationname' );
is( $obj->get_mcc( $ip ),'-','get_mcc' );
is( $obj->get_mnc( $ip ),'-','get_mnc' );
is( $obj->get_mobilebrand( $ip ),'-','get_mobilebrand' );
is( $obj->get_elevation( $ip ),'429','get_elevation' );
is( $obj->get_usagetype( $ip ),'ISP','get_usagetype' );

cmp_deeply(
	[ $obj->get_all( $ip ) ],
	[
		'CH',
		'SWITZERLAND',
		'ZURICH',
		'ZURICH',
		'BLUEWIN IS AN LIR AND ISP IN SWITZERLAND.',
		'47.366669',
		'8.550000',
		'BLUEWIN.CH',
		'8045',
		'+02:00',
		'DSL',
		'41',
		'044',
		'SZXX0033',
		'ZURICH',
		'-',
		'-',
		'-',
		'429',
		'ISP'
	],
);
