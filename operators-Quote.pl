#!/usr/bin/perl

$a = 10;
 
$b = q{a = $a};
print "Value of q{a = \$a} = $b\n";

$b = qq{a = $a};
print "Value of qq{a = \$a} = $b\n";

# unix command execution
$t = qx{date};
print "Value of qx{date} = $t\n";