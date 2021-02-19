#!/usr/bin/perl
   
@list = (1, 2, 3, 4, 5);
foreach $a (@list) {
   print "Value of a = $a\n";
} continue {
   last if $a == 4;
}