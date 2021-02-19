#!/usr/bin/perl

$a = 100; 
# check the boolean condition using if statement
if($a < 20){
    # if condition is true then print the following
    printf "a is less than 20\n";
} else {
    # if condition is false then print the following
    printf "a is greater than 20\n";
}
print "value of a is : $a\n";

$a = "";
# check the boolean condition using if statement
if( $a ) {
   # if condition is true then print the following
   printf "a has a true value\n";
} else {
   # if condition is false then print the following
   printf "a has a false value\n";
}
print "value of a is : $a\n";