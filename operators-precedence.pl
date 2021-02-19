#!/usr/bin/perl

$a = 20;
$b = 10;
$c = 15;
$d = 5;
$e;

print "Value of \$a  = $a, \$b = $b, \$c = $c and \$d = $d\n";
 
$e = ($a + $b) * $c / $d;
print "Value of (\$a + \$b) * \$c / \$d is  = $e\n";

$e = (($a + $b) * $c )/ $d;
print "Value of ((\$a + \$b) * \$c) / \$d is  = $e\n";

$e = ($a + $b) * ($c / $d);
print "Value of (\$a + \$b) * (\$c / \$d ) is  = $e\n";

$e = $a + ($b * $c ) / $d;
print "Value of \$a + (\$b * \$c )/ \$d is  = $e\n";