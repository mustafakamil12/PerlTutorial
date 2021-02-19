#!/usr/bin/perl
 
$a = 21;
$b = 10;

print "Value of \$a = $a and value of \$b = $b\n";

if( $a == $b ) {
   print "$a == \$b is true\n";
} else {
   print "\$a == \$b is not true\n";
}

if( $a != $b ) {
   print "\$a != \$b is true\n";
} else {
   print "\$a != \$b is not true\n";
}

$c = $a <=> $b;
print "\$a <=> \$b returns $c\n";

if( $a > $b ) {
   print "\$a > \$b is true\n";
} else {
   print "\$a > \$b is not true\n";
}

if( $a >= $b ) {
   print "\$a >= \$b is true\n";
} else {
   print "\$a >= \$b is not true\n";
}

if( $a < $b ) {
   print "\$a < \$b is true\n";
} else {
   print "\$a < \$b is not true\n";
}

if( $a <= $b ) {
   print "\$a <= \$b is true\n";
} else {
   print "\$a <= \$b is not true\n";
}