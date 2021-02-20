#!/usr/bin/perl

 my $foo = 100;
 $foo = \$foo;
 
 print "Value of foo is : ", $$foo, "\n";