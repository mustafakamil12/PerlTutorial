#!/usr/bin/perl

opendir (DIR, '.') or die "Couldn't open directory, $!";  #  $! returns the actual error message
while ($file = readdir DIR) {
   print "$file\n";
}
closedir DIR;