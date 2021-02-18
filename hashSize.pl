#!/usr/bin/perl

%data = ('John Paul' => 45, 'Lisa' => 30, 'Kumar' => 40);

@kyes = keys %data;
$size = @kyes;

print "1 - Hash size: $size\n";

@values = values %data;
$size = @values;

print "2 - Hash size: $size\n";