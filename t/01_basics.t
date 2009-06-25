#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More qw( no_plan );

BEGIN {
    use_ok('Geo::Coordinates::GMap');
}

{
    my ($x, $y) = coord_to_tile( 86, 177, 1 );
    is( $x, 1, 'tile x is 0' );
    is( $y, 0, 'tile y is 1' );
}

