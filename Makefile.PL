#!perl

use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'Geo::IP2Location::Lite',
    VERSION_FROM     => 'lib/Geo/IP2Location/Lite.pm',
    AUTHOR           => 'Lee Johnson <leejo@cpan.org>',
    LICENSE          => 'perl',
    PREREQ_PM        => {
        'bigint'     => 0, # bigint was first released with perl v5.8.0
        'Readonly'   => 2,
    },
    TEST_REQUIRES => {
        'Test::Most'       => 0.31,
    },
    META_MERGE => {
        resources => {
            license    => 'http://dev.perl.org/licenses/',
            homepage   => 'https://metacpan.org/module/Geo::IP2Location::Lite',
            bugtracker => 'https://github.com/leejo/geo-ip2location-lite/issues',
            repository => 'https://github.com/leejo/geo-ip2location-lite'
        },
    },
    test => {
        RECURSIVE_TEST_FILES => 1,
    },
);

# vim: ts=4:sw=4:et
