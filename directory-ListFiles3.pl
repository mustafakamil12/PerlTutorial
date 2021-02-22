#!/usr/bin/perl

opendir(DIR, '/tmp/') or die "Couldn't open directory, $!"; #  $! returns the actual error message
foreach (sort grep(/^.*\.c$/,readdir(DIR))) {
   print "$_\n";
}
closedir DIR;