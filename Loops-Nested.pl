#!/usr/bin/perl
   
$a = 0;
$b = 0;

# outer while loop
while($a < 3) {
   $b = 0;
   # inner while loop
   while($b < 3) {
      print "value of a = $a, b = $b\n";
      $b = $b + 1;
   }
   $a = $a + 1;
   print "Value of a = $a\n\n";
}