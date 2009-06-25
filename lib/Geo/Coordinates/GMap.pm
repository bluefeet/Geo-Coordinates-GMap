package Geo::Coordinates::GMap;

=head1 NAME

Geo::Cordinates::GMap - Routines for converting decimal lat/lon to Google
Map tiles, and back again.

=head1 SYNOPSIS

    use Geo::Cordinates::GMap;
    my ($tile_x, $tile_y, $x, $y) = coord_to_tile( $lat, $lon, $zoom );

=head1 DESCRIPTION

While working on the mapping tools on toxicrisk.com I came to the conclusion
that we were dealing with too much data to make everything a GMarker, even
when using the marker manager.

So, I needed to generate static map tile images.  But, to do this, I needed a
way to convert my decimal lat/lon points in to tile numbers, and the pixel
values on those tiles.

This module makes this proces simple and accurate.

=cut

use strict;
use warnings;

our $VERSION = '0.01';

use Math::Trig;

use Exporter qw( import );
our @EXPORT = qw( coord_to_tile );

=head1 FUNCTIONS

=head2 coord_to_tile

    my ($tile_x, $tile_y, $x, $y) = coord_to_tile( $lat, $lon, $zoom );

Given a decimal latitude and longitude, and a google maps zoom level (0 being farthest away
and 19 being the closest that I'm aware of that you can get), this function will return the
following list of values:

=over

=item tile_x: The tiles x-coordinate.

=item tile_y: The tiles y-coordinate.

=item x: The x position of the pixel within the tile.

=item y: The y position of hte pixel within the tile.

=back

=cut

# Inspired by some C# code at:
# http://groups.google.co.in/group/Google-Maps-API/browse_thread/thread/d2103ac29e95696f

sub coord_to_tile {
    my ($lat, $lon, $zoom) = @_;

    # The C# code did this, but I don't know why, so I'm not going to enable it.
    #return if abs($lat) > 85.0511287798066;

    my $sin_phi = sin( $lat * pi / 180 );

    my $norm_x = $lon / 180;
    my $norm_y = (0.5 * log((1 + $sin_phi) / (1 - $sin_phi))) / pi;

    my $y = (2 ** $zoom) * ((1 - $norm_y) / 2);
    my $x = (2 ** $zoom) * (($norm_x + 1) / 2);

    return(
        int($x),
        int($y),
        int( (($x - int($x)) * 256) + 0.5),
        int( (($y - int($y)) * 256) + 0.5),
    );
}

1;
__END__

=head1 TODO

=over

=item Implement a routine to convert tile coordinates back in to
lat/lon decimal coordinates.

=back

=head1 AUTHOR

Aran Clary Deltac <bluefeet@cpan.org>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

