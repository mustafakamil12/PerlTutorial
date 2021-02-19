#!/usr/bin/perl
   
$a = 0;
while($a < 10) {
   if( $a == 5 ) {
      $a = $a + 1;
      redo;
   }
   print "Value of a = $a\n";
} continue {
   $a = $a + 1;
}