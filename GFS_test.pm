package GFS_time;
use strict;


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

    $self->{'time_t'} = $time_t;

    bless $self, $class;
}

sub parse_time_string
{
    my($str) = @_;
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