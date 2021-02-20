#!/usr/bin/perl
=begin comment
Tyep of reference:
SCALAR
ARRAY
HASH
CODE
GLOB
REF
=cut

$var = 10;
$r = \$var;
print "Reference type in r : ", ref($r), "\n";

@var = (1, 2, 3);
$r = \@var;
print "Reference type in r : ", ref($r), "\n";

%var = ('key1' => 10, 'key2' => 20);
$r = \%var;
print "Reference type in r : ", ref($r), "\n";