#!/usr/bin/perl 
#     $Revision: /main/1 $     $Modtime: 01/02/20 17:29:30 $    $Author: marshall $
#
#   Perl module:
#     
#      GFS_time_interval
#
#   Description:
#
#      Object to represent an interval of time within the Global Forecast 
#      System.
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

package GFS_time_interval;

use strict;

#
#  Method       - new  
#  Description  - Converts a textual time interval into an integral number of
#                 seconds and/or months.
#  Arguments    - $1 = textual time interval, must be one of: 
#                     years, months, days, hours, minutes, seconds 
#                 The trailing 's' is optional. 
#                 The time inteval can be prefaced by an integer value, e.g.
#                     "6 hours" or "10 minutes"
#                 The SQL format used by Postgres for interval type is also
#                 supported
#  Returns      - Reference to a GFS_time_interval, or undef on failure. 
#
sub new 
{
    my $class = shift;
    my $self  = {};
    my $time_interval = shift;

    my $seconds = 0;
    my $months  = 0;
    if (!defined($time_interval))
    {
        # Assume time interval is 0 seconds....
    }
    elsif ($time_interval =~ 
            /(\d+ years |)(\d+ mons |)(\d+ |)(\d\d):(\d\d)(:\d\d|)/)
    {
        #
        #  PostgreSQL interval format.  TODO - Determine if this an ANSI
        #  standard for all SQL-compliant databases.
        #
        my $years = $1;
        my $mons = $2;
        my $days = $3;
        my $hours = $4;
        my $minutes = $5;
        my $secs = $6; 
        
        if ($years =~ /(\d+) years /) 
        {
           $years = $1;
        } 
            
        if ($mons =~ /(\d+) mons /) 
        {
           $mons = $1;
        } 
            
        if ($secs =~ /:(\d+)/) 
        {
           $secs = $1;
        } 

        $months += $years * 12 + $mons;
        $seconds += $days * 86400 + $hours * 3600 + $minutes * 60 + $secs;  
    }
    elsif ($time_interval =~ / *([-+]{0,1}\d*) *hour/)
    {
        if ($1 eq "")
        {
            $seconds = 3600; 
        }
        else
        {
            $seconds = $1 * 3600;
        }
    }
    elsif ($time_interval =~ / *([-+]{0,1}\d*) *minute/)
    {
        if ($1 eq "")
        {
            $seconds = 60; 
        }
        else
        {
            $seconds = $1 * 60;
        }
    }
    elsif ($time_interval =~ / *([-+]{0,1}\d*) *day/)
    {
        if ($1 eq "")
        {
            $seconds = 86400; 
        }
        else
        {
            $seconds = $1 * 86400; 
        }
    }
    elsif ($time_interval =~ / *([-+]{0,1}\d*) *second/)
    {
        if ($1 eq "")
        {
            $seconds = 1; 
        }
        else
        {
            $seconds = $1; 
        }
    }
    elsif ($time_interval =~ / *([-+]{0,1}\d*) *month/)
    {
        if ($1 eq "")
        {
            $months = 1; 
        }
        else
        {
            $months = $1; 
        }
    }
    elsif ($time_interval =~ / *([-+]{0,1}\d*) *year/)
    {
        if ($1 eq "")
        {
            $months = 12; 
        }
        else
        {
            $months = $1 * 12; 
        }
    }
    else
    {
        print STDERR "Unsupported time unit ", $time_interval, "\n";  
    }

    $self->{seconds} = $seconds;
    $self->{months}  = $months;

    bless $self, $class;
}

sub seconds
{
    my $self = shift;
    return $self->{seconds};
}
              
sub months
{
    my $self = shift;
    return $self->{months};
}

sub make_negative
{
    my $self = shift;
    my $months = $self->{months};
    if ($months > 0)
    {
        $self->{month} = -1 * $months;
    } 
              
    my $seconds = $self->{seconds};
    if ($seconds > 0)
    {
        $self->{seconds} = -1 * $seconds;
    } 
}

sub make_positive
{
    my $self = shift;
    my $months = $self->{months};
    if ($months < 0)
    {
        $self->{month} = -1 * $months;
    } 
              
    my $seconds = $self->{seconds};
    if ($seconds < 0)
    {
        $self->{seconds} = -1 * $seconds;
    } 
}

    
1;  # Force a return value of 1 when this package is loaded 
