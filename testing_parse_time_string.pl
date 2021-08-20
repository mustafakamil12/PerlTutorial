use Data::Dumper;
use lib "/Users/mustafaalogaidi/Desktop/MyWork/TutorialsPoint-Perl/";
#use Time::timegm qw( timegm );
require "timelocal.pl";

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
        #print"\$time_t = $time_t\n";
        #print "\@struct_t = @struct_t\n";
    }
}

sub timegmt
{
    my $struct_tm_ref = shift;
    #
    # We can't support years prior to 1970, or after 2037
    # This code insures that any time outside of this range
    # will be set to the closest time inside the range.
    #
    print Dumper $struct_tm_ref;
    if ($struct_tm_ref->[5] < 70)
    {
        splice @$struct_tm_ref,0,6,(0,0,0,1,0,36);
    }
    if ($struct_tm_ref->[5] > 137)
    {
        splice @$struct_tm_ref,0,6,(59,59,23,31,11,137);
    }
    print "\@$struct_tm_ref = @$struct_tm_ref\n";
    return timegm(@$struct_tm_ref);

}

#parse_time_string '2021-07-09 00:00:00'
print parse_time_string '2021-07-09'
