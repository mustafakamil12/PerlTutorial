#!/usr/bin/perl

@var_10 = (1..10);
@var_20 = (10..20);
@var_abc = (a..z);

print "@var_10\n";
print "@var_20\n";
print "@var_abc\n";

print "Size: ",scalar @var_10,"\n";
print "";
$mySize = @var_10;    # we assign variable start with @ to variable with $ :)
$maxIndex = $#var_10;
print "Size: $mySize\n";
print "Max Index: $maxIndex\n";
