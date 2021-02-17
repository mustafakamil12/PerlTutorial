#!/usr/bin/perl

print "File name: ". __FILE__ ."\n";
print "Line number: ". __LINE__ ."\n";
print "Package: ". __PACKAGE__ ."\n";

# They can not be interpolated
print "__FILE__ __LINE__ __PACKAGE__\n"
