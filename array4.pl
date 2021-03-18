#!/usr/local/bin/perl

$total = 0;
&getnumbers;

foreach $number (@numbers) {

          $total += $number;

}

print ("the total is $total\n");

sub getnumbers {

         $line = <STDIN>;

         $line =~ s/^\s+|\s*\n$//g;

         @numbers = split(/\s+/, $line);

}
