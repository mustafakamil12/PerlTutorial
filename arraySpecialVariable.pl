#!/usr/bin/perl

# define an array
@foods = qw(pizza steak chicken burgers);
print "Foods: @foods\n";
print "Food at \$foods[0]: $foods[0]\n";

# Let's reset first index of all the arrays.
$[ = 1;

print "After change index\n";
print "Food at \$foods[1]: $foods[1]\n";
print "Food at \$foods[2]: $foods[2]\n";