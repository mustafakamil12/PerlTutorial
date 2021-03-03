#!/usr/bin/perl

use strict;
use warning;
use feature qw/say/;
use Shape;
use Shape::Circle;

=begin comment
# create a new Shape object 
my $shape = Shape->new;
=end comment
=cut
#----------------------------------------------------------
=begin comment
# pass color, length and width arguments to the constructor
my $shape = Shape->new({
                color => 'red',
                length=> 2,
                width => 2,
            });


# print the shape object attributes

say $shape->{color};
say $shape->{length};
say $shape->{width};
=end comment
=cut
#----------------------------------------------------------
=begin comment
# pass color, length and width arguments to the constructor
my $red_shape = Shape->new({
                    color => 'red',
                });
# use the default attribute values
my $black_shape = Shape->new;

say $red_shape->{color};
say $black_shape->{color};
=end comment
=cut
#----------------------------------------------------------
=begin comment
# pass color, length and width arguments to the constructor
my $red_shape = Shape->new({
                    color => 'red',
                    length=> 2,
                    width => 2,
                });
# calculate the area of $red_shape
my $area = $red_shape->{length} * $red_shape->{width};

# insert the area attribute and value into $red_shape
$red_shape->{area} = $area;

say $red_shape->{area};
=end comment
=cut
#----------------------------------------------------------

=begin comment
# pass color, length and width arguments to the constructor
my $red_shape = Shape->new({
                color => 'red',
                length=> 2,
                width => 2,
            });
# call the area method and print the value
say $red_shape->get_area;
=end comment
=cut
#----------------------------------------------------------
=begin comment
# pass color argument to the constructor
my $shape = Shape->new({
                color => 'red',
            });

# print the shape color using get_color method
say $shape->get_color;

# set the shape color to blue
$shape->set_color('blue');

# print the shape color using get_color method
say $shape->get_color;

# get datetime
say $shape->get_datetime;
=end comment
=cut

#----------------------------------------------------------
# using circle 

my $circle = Shape::Circle->new;

# get datetime - inherited method
say $circle->get_datetime;

# try new Circle methods
say $circle->get_radius;
say $circle->get_circumference;
say $circle->get_area;