#!/usr/bin/perl

$string = "The cat sat on the mat and spend \$30 Dollars";
$string =~ s/cat/dog/;

print "$string\n";

$string =~ s/\$/\\\$/g;
$string =~ s/ (\S*[\$#]\S*) / '"'"'"$1"'"'"' /g;

print "$string\n";
