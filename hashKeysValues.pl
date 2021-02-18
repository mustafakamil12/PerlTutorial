#!/usr/bin/perl

%data = (-JohnPaul => 45, -Lisa => 30, -Kumar => 40);
%data1 = ('John Paul', 45, 'Lisa', 30, 'Kumar', 40);

@names = keys %data1;

print "Keys: \n";
print "$names[0]\n";
print "$names[1]\n";
print "$names[2]\n";

print "\n";

@ages = values %data;

print "Values: \n";
print "$ages[0]\n";
print "$ages[1]\n";
print "$ages[2]\n";