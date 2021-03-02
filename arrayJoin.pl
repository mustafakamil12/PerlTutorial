#!/usr/bin/perl

# define strings
$var_string = "Rain-Drops-On-Roses-And-Whiskers-On-Kittens";
$var_names = "Larry,David,Roger,Ken,Michael,Tom";

# transform above strings into arrayes.
@string = split('-', $var_string);
@names = split(',', $var_names);

$string1 = join('-', @string);
$string2 = join(',', @names);

print "@string\n";
print "@names\n";
print "$string1\n";
print "$string2\n"; 


