#!/usr/bin/perl

$dir = "/home";

# This changes perl directory  and moves you inside /home directory.
chdir( $dir ) or die "Couldn't go inside $dir directory, $!"; #  $! returns the actual error message
print "Your new location is $dir\n";