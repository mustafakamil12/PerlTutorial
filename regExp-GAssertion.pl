#!/usr/bin/perl

$string = "The time is: 12:31:02 on 4/12/00";
print "$string\n";
$string =~ /:\s+/g;
print "$string\n";
($time) = ($string =~ /\G(\d+:\d+:\d+)/);
print "$time\n";
$string =~ /.+\s+/g;
print "$string\n";
($date) = ($string =~ m{\G(\d+/\d+/\d+)});

print "Time: $time, Date: $date\n";