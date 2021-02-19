#!/usr/bin/perl
 
$a = 5;

# until loop execution
until( $a > 10 ) {
   printf "Value of a: $a\n";
   $a = $a + 1;
}