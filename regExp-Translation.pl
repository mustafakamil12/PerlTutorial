#!/usr/bin/perl

$string = 'The cat sat on the mat';
$string =~ tr/a/o/;
print "$string\n";

$string =~ tr/a-z/A-Z/;
print "$string\n";