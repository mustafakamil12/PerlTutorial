#!/usr/bin/perl

# This is main package
$i = 1; 
print "Package name : " , __PACKAGE__ , " $i\n"; 

package Foo;
# This is Foo package
$i = 10; 
print "Package name : " , __PACKAGE__ , " $i\n"; 

package main;
# This is again main package
$i = 100; 
print "Package name : " , __PACKAGE__ , " $i\n"; 
print "Package name : " , __PACKAGE__ ,  " $Foo::i\n"; 

1;