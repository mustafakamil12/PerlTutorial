#!/usr/bin/perl
   
$a = 10;
$str1 = "LO";
$str2 = "OP";

LOOP:do {
   if( $a == 15) {
      # skip the iteration.
      $a = $a + 1;
      # use goto EXPR form
      goto $str1.$str2;
   }
   print "Value of a = $a\n";
   $a = $a + 1;
} while( $a < 20 );