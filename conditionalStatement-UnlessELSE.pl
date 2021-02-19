#!/usr/bin/perl
 
$a = 100;
# check the boolean condition using unless statement
unless( $a == 20 ) {
   # if condition is false then print the following
   printf "given condition is false\n";
} else { 
   # if condition is true then print the following
   printf "given condition is true\n";
}
print "value of a is : $a\n";

$a = 50;
# check the boolean condition using unless statement
unless( $a ) {
   # if condition is false then print the following
   printf "a has a false value\n";
} else {
   # if condition is true then print the following
   printf "a has a true value\n";
}
print "value of a is : $a\n";