#!/usr/bin/perl

package Foo;
print "Begin and Block Demo\n";

BEGIN { 
   print "This is BEGIN Block\n" 
}

END { 
   print "This is END Block\n" 
}

1;