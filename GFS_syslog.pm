#!/usr/bin/perl 
#     $Revision: /main/2 $     $Modtime: 01/05/09 01:19:17 $    $Author: bwp $
#
#   Perl module:
#     
#      GFS_syslog
#
#   Description:
#
#      Functions to send log information via syslog.
#      
#   Copyright (C) 2000, WSI Corporation
#
#   These coded instructions, statements, and computer programs contain
#   unpublished proprietary information of WSI Corporation, and are 
#   protected by Federal copyright law.  They may not be disclosed 
#   to third parties or copied or duplicated in any form, in whole or
#   in part, without the prior written consent of WSI Corporation. 
#
#------------------------------------------------------------------------------

package GFS_syslog;

$scripts_dir = $ENV{'GFS_BASE'} . "/bin/";

sub gfs_log {
    ($facility, $severity, $message) = @_;
    system ("logger", "-t",  $facility, "-p", "local0.$severity", $message);
}

sub gfs_alert {
    open GFS_ALERT, "|".$scripts_dir."/gfs_alert";
    print GFS_ALERT $_[0];
    close GFS_ALERT;
}

sub db_log {
    gfs_log ("GFS_DB", @_);
}

sub db_log_info {
    db_log ("info", $_[0]);
}

sub db_log_error {
    db_log ("err", $_[0]);
}

sub db_log_alert {
    db_log_error $_[0];
    gfs_alert $_[0];
}

sub frmt_log {
    gfs_log ("GFS_FRMT", @_);
}

sub frmt_log_info {
    frmt_log ("info", $_[0]);
}

sub frmt_log_error {
    frmt_log ("err", $_[0]);
}

sub frmt_log_alert {
    frmt_log_error $_[0];
    gfs_alert $_[0];
}

sub db_tool_log {
    gfs_log ("DB_TOOL", @_);
}

sub db_tool_log_info {
    db_tool_log ("info", $_[0]);
}

sub db_tool_log_error {
    db_tool_log ("err", $_[0]);
}

sub db_tool_log_alert {
    db_tool_log_error $_[0];
    gfs_alert $_[0];
}

1;  # Force a return value of 1 when this package is loaded 
