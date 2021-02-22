#!/usr/bin/perl 

use strict; 
use warnings; 

# reference to array 
my $arr1 = [4,5,6]; 

# array inside array 
my $arr2 = [4,5,[6,7]]; 

# reference to hash 
my $has1 = {'a'=>1,'b'=>2}; 

# hash inside hash 
my $has2 = {'a'=>1,'b'=>2,'c'=>[1,2],'d'=>{'x'=>3,'y'=>4}}; 

# using arrow operator 
print "$arr1->[0]\n"; 
#print "$arr1[0]\n";
print "$arr2->[1]\n"; 
print "$arr2->[2][0]\n"; 
print "$has2->{'a'}\n"; 
print $has2->{'d'}->{'x'},"\n"; 
print $has2->{'c'}->[0],"\n"; 
