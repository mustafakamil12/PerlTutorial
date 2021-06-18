#!/usr/bin/perl

%data = (-JohnPaul => 45, -Lisa => 30, -Kumar => 40);
%data1 = ('John Paul', 45, 'Lisa', 30, 'Kumar', 40);

@array = @data{-JohnPaul, -Lisa};

print "Array: @array\n";

print "=====================\n";


$record = '2021-10-17 05:00:00.0';

print "\%{\$record} = %{$record}\n";

%record_hash = %{$record};
print "\%record_hash = %record_hash \n";
#print "ParseFormattedDateTime\n";
#print "\$record_hash{'dateHrGmt'} = $record_hash{'dateHrGmt'}\n";
