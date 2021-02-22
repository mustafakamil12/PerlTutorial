#!/usr/bin/perl

$string = "The food is in the salad bar";
$string =~ m/foo/;
print "Before: $`\n";  # everything before match
print "Matched: $&\n"; # the match exactly
print "After: $'\n";   # everything after match