#!/usr/bin/perl

# define strings
$var_string = "Rain-Drops-On-Roses-And-Whiskers-On-Kittens";
$var_names = "Larry,David,Roger,Ken,Michael,Tom";

# transform above strings into arrays.
#         split [ PATTERN [ , EXPR [ , LIMIT ] ] ]
@string = split('-', $var_string);
@names = split(',', $var_names);

print "\@string = @string\n";
print "\@names = @names\n";
print "$string[3]\n"; # This will print Roses
print "$names[4]\n"; # This will print Michael
