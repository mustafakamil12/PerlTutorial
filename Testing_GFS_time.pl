#!/usr/bin/perl
use Data::Dumper;
use lib "/Users/mustafaalogaidi/Desktop/MyWork/TutorialsPoint-Perl";     # Add library directory to lib path.
use strict;
use GFS_time;

# Time/Date Strings
my $today = new GFS_time;
print Dumper($today);
my $yyyy = $today->as_text("%Y");
my $mm = $today->as_text("%m");
my $dd = $today->as_text("%d");
my $yyyymmdd = $yyyy . $mm . $dd;
my $inputdate = "$yyyy-$mm-$dd";

my $validtime = new GFS_time("$inputdate 00:00:00");
print Dumper($validtime);
my $initstring = $today->as_text("%Y") .
	    "-" . $today->as_text("%m") .
	    "-" .$today->as_text("%d") .
	    " " . $today->as_text("%H:%M:%S");

my $param_code = 19;
my $fcst_source = 3;

my $cmd  = "Date";
if (system($cmd) != 0)
{
  print "cmd != 0\n";
}
else{
  print "cmd == 0 \n";
}
