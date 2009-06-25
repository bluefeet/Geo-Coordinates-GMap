use strict;
use warnings;

use inc::Module::Install;

name     'Geo-Coordinates-GMap';
perl_version '5.008003';
all_from 'lib/Geo/Coordinates/GMap.pm';

requires 'Math::Trig';

build_requires 'Test::More' => 0.62;

WriteAll;

