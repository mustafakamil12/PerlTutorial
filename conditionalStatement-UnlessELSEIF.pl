#!/usr/bin/perl
 
$a = 40;
# check the boolean condition using if statement
unless( $a ) {
   # if condition is false then print the following
   printf "a has no value\n";
} elsif( $a ==  30 ) {
   # if condition is true then print the following
   printf "a has a value which is 30\n";
} else {
   # if none of the above conditions is met
   printf "a has a value which is $a\n";
}