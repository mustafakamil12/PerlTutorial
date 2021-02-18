#!/usr/bin/perl

@days = qw/Mon Tue Wed Thu Fri Sat Sun/;

#@weekdays = @days[3,4,5];
@weekdays = @days[3..5];

print "@weekdays\n";