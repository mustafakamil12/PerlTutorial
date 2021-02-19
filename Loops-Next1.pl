#!/usr/bin/perl

$a = 10;
while( $a < 20 ) {
   if( $a == 15) {
      # skip the iteration.
      $a = $a + 1;
      next;
   }
   print "value of a: $a\n";
   $a = $a + 1;
}