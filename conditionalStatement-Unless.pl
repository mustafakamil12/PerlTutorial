#!/usr/bin/perl
 
$a = 20;
# check the boolean condition using unless statement
unless( $a < 20 ) {
   # if condition is false then print the following
   printf "a is not less than 20\n";
}
print "value of a is : $a\n";

$a = "";
# check the boolean condition using unless statement
unless ( $a ) {
   # if condition is false then print the following
   printf "a has a false value\n";
}
print "value of a is : $a\n";