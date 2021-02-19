#!/usr/bin/perl
 
$a = 10;
$b = 20;

print "Value of \$a = $a and value of \$b = $b\n";

$c = $a + $b;
print "After assignment value of \$c = $c\n";

$c += $a;
print "Value of \$c = $c after statement \$c += \$a\n";

$c -= $a;
print "Value of \$c = $c after statement \$c -= \$a\n";

$c *= $a;
print "Value of \$c = $c after statement \$c *= \$a\n";

$c /= $a;
print "Value of \$c = $c after statement \$c /= \$a\n";

$c %= $a;
print "Value of \$c = $c after statement \$c %= \$a\n";

$c = 2;
$a = 4;
print "Value of \$a = $a and value of \$c = $c\n";
$c **= $a;
print "Value of \$c = $c after statement \$c **= \$a\n";