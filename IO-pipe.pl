#!/usr/bin/perl

$message = "Testing Sehll Codes";
$scripts_dir = '/Users/mustafaalogaidi/Desktop/MyWork/TutorialsPoint-Perl';
open GFS_ALERT, "| ".$scripts_dir."/gfs_alert";
print GFS_ALERT $message;
while ( defined( my $line = <GFS_ALERT> )  ) {
     chomp($line);
     print "$line\n";
   }
close GFS_ALERT;