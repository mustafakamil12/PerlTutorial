#!/usr/bin/perl

$scripts_dir = '/Users/mustafaalogaidi/Desktop/MyWork/TutorialsPoint-Perl'
open GFS_ALERT, "|".$scripts_dir."/gfs_alert";
print GFS_ALERT $_[0];
close GFS_ALERT;