#!perl

use strict;
use warnings;

use Benchmark qw/ cmpthese /;
use Geo::IP2Location;
use Geo::IP2Location::Lite;

my $file = 'samples/IP-COUNTRY-SAMPLE.BIN';

my $obj = Geo::IP2Location->open( $file );
my $obj_lite = Geo::IP2Location::Lite->open( $file );

cmpthese(
	-1,
	{
		'lookup'       => sub {
			my $country = $obj->get_country_short( '53.5.10.6' );
		},
		'lookup lite'  => sub {
			my $country = $obj_lite->get_country_short( '53.5.10.6' );
		},
	}
);

__END__
