#!/usr/bin/perl
 
$a = "abc";
$b = "xyz";

print "Value of \$a = $a and value of \$b = $b\n";

if( $a lt $b ) {
   print "$a lt \$b is true\n";
} else {
   print "\$a lt \$b is not true\n";
}

if( $a gt $b ) {
   print "\$a gt \$b is true\n";
} else {
   print "\$a gt \$b is not true\n";
}

if( $a le $b ) {
   print "\$a le \$b is true\n";
} else {
   print "\$a le \$b is not true\n";
}

if( $a ge $b ) {
   print "\$a ge \$b is true\n";
} else {
   print "\$a ge \$b is not true\n";
}

if( $a ne $b ) {
   print "\$a ne \$b is true\n";
} else {
   print "\$a ne \$b is not true\n";
}

$c = $a cmp $b;
print "\$a cmp \$b returns $c\n";