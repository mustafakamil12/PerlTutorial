#!/usr/bin/perl

opendir(DIR, '/tmp/') or die "Couldn't open directory, $!";
foreach (sort grep(/^.*\.c$/,readdir(DIR))) {
   print "$_\n";
}
closedir DIR;