#!/usr/bin/perl

opendir (DIR, '.') or die "Couldn't open directory, $!";
while ($file = readdir DIR) {
   print "$file\n";
}
closedir DIR;