#!/usr/bin/perl
#     $Revision: /main/4 $     $Modtime: 01/07/26 12:50:22 $    $Author: bwp $
#
#   Perl module:
#
#      GFS_time
#
#   Description:
#
#      Object to represent an absolute date-time, used within the Global
#      Forecast System.
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

package GFS_time;
use Data::Dumper;
use strict;
#require "timelocal.pl";
use Time::Local;
use POSIX;
use GFS_time_interval;

#
#  Default time format of the ISO, of the form:
#
#      "YYYY-MM-DD hh:mm:ss[+-]hh[:mm[:ss]]"
#
#  where YYYY is 4 digit year
#          MM is 2 digit month
#          DD is 2 digit day of month
#          hh is 2 digit hour
#          mm is 2 digit minute
#          ss is 2 digit second
#
#  The second hh:mm:ss represents the offset of this time from UTC.
#  This is used for local times, and the minutes and seconds are omitted if
#  the timezone if a integral number of hours from UTC time, e.g. "+00"
#  represents UTC time, while "-04" represents US Eastern Daylight Time.
#
$GFS_time::ISO_FORMAT = "%Y-%m-%d %H:%M:%S%z";

#
#  Method      - new
#  Description - Constructs a new GFS_time object.
#  Arguments   - All are optional
#                $1 = date or date time formatted as text.
#  Returns     - Reference to a GFS_time object.
#  Uses        -
#
sub new
{
    my $class = shift;
    my $self  = {};

    my $time_t;
    if (defined $_[0])
    {
        if (ref $_[0] eq $class)  # Copying another GFS_time object
        {
            my $other = shift;
            $time_t = $other->time_t();
        }
        else  # Initializing from a formatted time string.
        {
            $time_t = parse_time_string(shift);
        }
    }
    else
    {
        $time_t = time();
    }
    print "\$time_t = $time_t\n";
    $self->{'time_t'} = $time_t;

    bless $self, $class;
}

#
#  Method      - copy_from
#  Description - Copies the time from one GFS_time object to another.
#  Arguments   - $1 = A reference to a GFS_time object to copy.
#  Returns     - 1 on success, 0 on failure.
#  Uses        - Modify the value of a GFS_time.
#
sub copy_from
{
    my $self   = shift;
    if (!defined($_[0]))
    {
       return 0;
    }

    $self->{'time_t'} = $_[0]->{'time_t'};
    return 1;
}

#
#  Method      - time_t
#  Description - Returns the Unix time_t associated with a GFS_time object.
#  Arguments   - None.
#  Returns     - time_t of the object (-1 denotes invalid value).
#  Uses        - Get at the GFS_time implementation.
#
sub time_t
{
    my $self = shift;
    return $self->{'time_t'};
}

#
#  Method      - set_to_now
#  Description - Sets the GFS_time object to the current system time.
#  Arguments   - None.
#  Returns     - time_t of the object (-1 denotes invalid value).
#  Uses        - Reset a GFS_time object.
#
sub set_to_now
{
    my $self = shift;
    my $time_t = time();
    $self->{'time_t'} = $time_t;
    return $time_t;
}

#
#  Method      - add_seconds
#  Description - Adds the a time period in seconds to the internal time.
#  Arguments   - $1 = number of seconds to add.
#  Returns     - The number of seconds added.
#  Uses        - Modify the values of a GFS_time.
#  Notes       - Invalid GFS_time objects are NOT modified.
#
sub add_seconds
{
    my $self   = shift;
    my $time_t = $self->{'time_t'};
    if ($time_t == -1)
    {
        return 0;
    }

    my $secs = 0;
    if (defined $_[0])
    {
        $secs = shift;
        $self->{'time_t'} += $secs;
    }
    return $secs;
}

#
#  Method      - increment_by
#  Description - Adds the a time interval (represented by a GFS_time_interval)
#                to the internal time.
#  Arguments   - $1 = reference to a GFS_time_interval.
#  Returns     - The change to the time in seconds.
#  Uses        - Modify the values of a GFS_time.
#  Notes       - Invalid GFS_time objects are NOT modified.
#
sub increment_by
{
    my $self   = shift;
    my $time_t = $self->{'time_t'};
    if ($time_t == -1)
    {
        return 0;
    }
    my $time_interval = shift;
    if (!defined($time_interval))
    {
        print STDERR
                "GFS_time.increment_by: a time interval must be specified\n";
        return 0;
    }

    if (ref $time_interval ne "GFS_time_interval")
    {
        my $gfs_time_interval = new GFS_time_interval($time_interval);
        if (!defined($gfs_time_interval))
        {
            print STDERR "GFS_time.increment_by: invalid time interval ",
                $time_interval, "\n";
            return 0;
        }
        $time_interval = $gfs_time_interval;
    }

    my $months  = $time_interval->months();
    my $seconds = $time_interval->seconds();
    $self->{'time_t'} += $seconds;

    if ($months != 0)
    {
        #
        #  Create a "broken down" time structure w/o any local time adjustments
        #
        my $time_t = $self->{'time_t'};
        my @time_tm = gmttime($time_t);

        my $years_to_add = $months / 12;
        my $months_to_add = $months % 12;

        my $months = $time_tm[4] + 1;
        my $years_since_1900 = $time_tm[5];

        my $month_sum = $months + $months_to_add;
        if ($month_sum > 12)
        {
            $years_to_add++;
            $months = $month_sum - 12;
        }
        elsif ($month_sum < 0)
        {
            $years_to_add--;
            $months = $month_sum + 12;
        }
        else
        {
            $months = $month_sum;
        }

        $years_since_1900 += $years_to_add;

        $time_tm[4] = $months - 1;
        $time_tm[5] = $years_since_1900;

        my $new_time_t = timegmt(\@time_tm);

        $seconds += ($new_time_t - $time_t);
        $self->{'time_t'} = $new_time_t;
    }

    return $seconds;
}

#
#  Method      - seconds_after
#  Description - Find the time interval between two GFS_times.
#  Arguments   - $1 = another GFS_time object.
#  Returns     - The time associated with this GFS_time minus the time
#                associated with the other in seconds.  If either GFS_time
#                object is invalid, 0 is returned.
#  Uses        - Find the time interval between two absolute times.
#  Notes       - To get a positive time interval, this method should be called
#                on the later of the two GFS_times, e.g. on the GFS_time that
#                represents the end of a time range.
#
sub seconds_after
{
    my $self   = shift;
    my $time_t = $self->{'time_t'};
    if ($time_t == -1)
    {
        return 0;
    }

    my $other = shift;
    my $other_time_t = $other->{'time_t'};
    if ($other_time_t == -1)
    {
        return 0;
    }

    return $time_t - $other_time_t;
}

#
#  Class Method - time_interval_in_seconds
#  Description  - Converts a textual time interval into an integral number of
#                 seconds
#  Arguments    - $1 = textual time interval, must be one of:
#                     days, hours, minutes
#                 The time inteval can be prefaced by an integer value, e.g.
#                     "6 hours" or "10 minutes"
#  Returns     - time in seconds if the interval could be decoded; 0 otherwise
#
sub time_interval_in_seconds
{
    my ($class, $time_interval) = @_;

    my $time_int_secs = 0;
    if ($time_interval =~ / *([-+]{0,1}\d*) *hour/)
    {
        if ($1 eq "")
        {
            $time_int_secs = 3600;
        }
        else
        {
            $time_int_secs = $1 * 3600;
        }
    }
    elsif ($time_interval =~ / *([-+]{0,1}\d*) *minute/)
    {
        if ($1 eq "")
        {
            $time_int_secs = 60;
        }
        else
        {
            $time_int_secs = $1 * 60;
        }
    }
    elsif ($time_interval =~ / *([-+]{0,1}\d*) *day/)
    {
        if ($1 eq "")
        {
            $time_int_secs = 86400;
        }
        else
        {
            $time_int_secs = $1 * 86400;
        }
    }
    else
    {
        print STDERR "Unsupported time unit ", $time_interval, "\n";
    }
    return $time_int_secs;
}

#
#  Method      - truncate_to
#  Description - truncate the GFS_time object to the specified time interval.
#  Arguments   - $1 = name of unit of time:  must be one of:
#                     days, hours, minutes
#                The time unit can be prefaced by an integer value, e.g.
#                     "6 hours" or "10 minutes"
#  Returns     - 1 if the time could be truncated, 0 otherwise
#  Uses        - Remove excess precision in a time.
#
sub truncate_to
{
    my $self = shift;
    if (!defined $_[0])          # first argument = time unit
    {
        print STDERR "Can't truncate GFS_time: no time unit specified\n";
        return 0;   # no time unit specified.
    }

    my $time_unit = $_[0];
    my $time_t    = $self->{'time_t'};
    if ($time_t == -1)
    {
        GFS_log->warning($GFS_log::PARAMETER,
                "Can't truncate invalid GFS_time");
        return 0;   # GFS_time object is invalid.
    }

    my $time_int_secs = GFS_time->time_interval_in_seconds($time_unit);
    if ($time_int_secs > 0)
    {
        $time_t = int($time_t / $time_int_secs) * $time_int_secs;
    }
    else
    {
        if ($time_int_secs < 0)
        {
            GFS_log->warning($GFS_log::PARAMETER,
                    "Cannot truncate time using a negative time interval");
        }
        else
        {
            GFS_log->warning($GFS_log::PARAMETER,
                    "Unsupported time unit %s", $time_unit);
        }
        return 0;  # unsupported time unit
    }

    $self->{'time_t'} = $time_t;
    return 1;
}

#
#  Method      - as_text
#  Description - presents the GFS_time object as text
#  Arguments   - $1 = Format for converting the time to text.  Conversion
#                     strings follow the convention of the C time library
#                     function strftime, with the addition of the %z group
#                     for formatting the offset of a local time from UTC time.
#                $2 = Offset from UTC time in seconds (optional).
#                $3 = Timezone abbreviation to substitute for the %Z group
#                     (optional).
#  Returns     - Textual representation of the time, or "" on error.
#  Uses        - To format time as text.
#
sub as_text
{
    my $self   = shift;
    my $time_t = $self->{'time_t'};
    if ($time_t == -1)
    {
        return "";
    }

    #
    #  Interpret the function's arguments.
    #
    my $fmt = $GFS_time::ISO_FORMAT;
    my $utc_offset = 0;
    my $tz_abbrev = "UTC";

    if (defined $_[0])          # first argument = format
    {
        $fmt = shift;
        if (defined $_[0])      # second argument = UTC offset
        {
            $utc_offset = shift;
            if (defined $_[0])  # third argument = timezone abbrev
            {
                $tz_abbrev = shift;
            }
        }
    }

    #
    #  Handle the special formatting group %z to denote utc offset.
    #
    if ($fmt =~ /\%z/)
    {
        #
        #  Format the UTC offset as "[+-]HH[:MM[:SS]]"
        #
        my $hours   = int($utc_offset / 3600);
        my $minutes = int($utc_offset / 60) - $hours * 60;
        my $seconds = $utc_offset - 3600 * $hours - 60 * $minutes;

        if ($minutes < 0) {$minutes = -1 * $minutes;}
        if ($seconds < 0) {$seconds = -1 * $seconds;}

        my $utc_offset_str;
        if ($seconds != 0)
        {
            $utc_offset_str = sprintf("%+2.2d:%2.2d:%2.2d",
                    $hours, $minutes, $seconds);
        }
        elsif ($minutes != 0)
        {
            $utc_offset_str = sprintf("%+2.2d:%2.2d", $hours, $minutes);
        }
        else
        {
            $utc_offset_str = sprintf("%+2.2d", $hours);
        }

        #
        #  Substitute the %z in the format string with the UTC offset string.
        #
        $fmt =~ s/\%z/$utc_offset_str/g;
    }

    #
    #  Handle the timezone abbreviation to avoid dependency on environment
    #  variable TZ.  This allows formatting for many local times, not just
    #  the one you happen to be in.
    #
    $fmt =~ s/\%Z/$tz_abbrev/g;

    #
    #  Offset the seconds since 1970 from UTC time as needed.
    #
    $time_t += $utc_offset;

    #
    #  Create a "broken down" time structure w/o any local time adjustments.
    #
    my @time_tm = gmttime($time_t);

    #
    #  Return the textual representation of the time.
    #
    return strftime($fmt, @time_tm);
}

#
#  Function    - parse_time_string
#  Description - Converts a formatted time string into a Unix integer time.
#  Arguments   - $1 = Textual representation of the time.
#  Returns     - Seconds since 1970 if format can be parsed; -1 otherwise.
#  Uses        - To interpret a textual representation of the time.
#                Generally, this is used internally by GFS_time.
#  TODO        - Eventually his should be replaced by the more general POSIX
#                function strptime.  However, strptime is new to POSIX and is
#                not currently supported in the perl POSIX API - SFM 9/22/00.
#
sub parse_time_string
{
    my($str) = @_;
    print "\$str = $str\n";
    my @struct_tm;      # "Broken-down" time structure.
    my $time_t = -1;    # Unix time to be returned.

    if ($str =~ /^(\d+)-(\d+)-(\d+)$/ )
    {
        #
        #  Time string starts with a date of the form "YYYY-MM-DD"
        #
        $struct_tm[0] = 0;              # second
        $struct_tm[1] = 0;              # minute
        $struct_tm[2] = 0;              # hour
        $struct_tm[3] = int($3);        # day of month
        $struct_tm[4] = int($2) - 1;    # month -1
        $struct_tm[5] = int($1) - 1900; # years since 1900
        $struct_tm[8] = -1;             # daylight savings time unknown

        #
        #  Convert the broken-down time to a Unix time, assuming time is
        #  specified as UTC.
        #
        $time_t = timegmt(\@struct_tm);
    }
    elsif ($str =~ /(\d+)-(\d+)-(\d+) (\d+):(\d+):(\d+)/)
    {
        #
        #  Time string is a date time of form "YYYY-MM-DD hh:mm:ss".
        #  Fill in the time-of-day variables.
        #
        $struct_tm[0] = int($6);        # second
        $struct_tm[1] = int($5);        # minute
        $struct_tm[2] = int($4);        # hour
        $struct_tm[3] = int($3);        # day of month
        $struct_tm[4] = int($2) - 1;    # month -1
        $struct_tm[5] = int($1) - 1900; # years since 1900
        $struct_tm[8] = -1;             # daylight savings time unknown

        #
        #  Convert the broken-down time to a Unix time, assuming time is
        #  specified as UTC.
        #
        print "\@struct_tm = @struct_tm\n";
        $time_t = timegmt(\@struct_tm);

        if ($str =~ /(\d+)-(\d+)-(\d+) (\d+):(\d+):(\d+)([+-]\d+)/)
        {
            #
            #  Time string is an ISO datetime string, with time zone offset
            #  (in hours) after the seconds.  We assumed the time was in UTC,
            #  so subtract the timezone offset to correct this assumption.
            #  Note: the offset is the number of hours that must be added to
            #  a UTC time to get the local time.
            #
            $time_t -= $7 * 3600;
        }
    }
    #
    #  Add more time formats here....
    #
    else
    {
        #
        #  If the time cannot be parsed, warn the user.
        #
        warn "Error: parse_time_string: $str not in a known datetime format\n";
    }
    return $time_t;
}

#
#  Function    - gmttime
#  Description - Converts seconds since 1970 into a "broken-down" time struct.
#  Arguments   - $1 = seconds since 1970 (Unix time)
#  Returns     - Array that mimics the elements of a C time library "struct tm"
#  Uses        - To break a Unix time down into its individual time elements.
#                Generally, this is used internally by GFS_time.
#  TODO        - This function really should not be necessary.  However, it
#                works around a problem with the standard gmtime function under
#                Linux.  The is_daylight parameter is returned as 0 (denoting
#                'not daylight savings time').  This seems like the right
#                thing to do, but strftime will not correctly format the time
#                unless it is set to -1 (denoting 'unknown').  SFM 9/22/00
#
sub gmttime
{
    my @struct_tm = gmtime($_[0]);
    $struct_tm[8] = -1;
    return @struct_tm;
}

#
#  Function    - timegmt
#  Description - Converts a "broken-down" time struct into seconds since 1970.
#  Arguments   - $1 = reference to time struct array.
#  Returns     - Scalar value seconds since 1970.
#  Uses        - To consolidate individual time elements into a compact form.
#                Generally, this is used internally by GFS_time.
#  TODO        - This function really should not be necessary.  However, it
#                works around a problem that we cannot represent times earlier
#                than 1970 as time_t values.  This is a limitation with the
#                C library time functions and should be worked around as needed.
#                SFM 2/20/01
#
sub timegmt
{
    my $struct_tm_ref = shift;
    print Dumper ($struct_tm_ref);
    #
    # We can't support years prior to 1970, or after 2037
    # This code insures that any time outside of this range
    # will be set to the closest time inside the range.
    #
    if ($struct_tm_ref->[5] < 70)
    {
        splice @$struct_tm_ref,0,6,(0,0,0,1,0,70);
    }
    if ($struct_tm_ref->[5] > 137)
    {
        splice @$struct_tm_ref,0,6,(59,59,23,31,11,137);
    }
    print "struct_tm_ref\n";
    print Dumper (@$struct_tm_ref);
    return timegm(@$struct_tm_ref);
}

1;  # Force a return value of 1 when this package is loaded
