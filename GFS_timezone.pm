package GFS_timezone;

use FindBin qw($Bin);   # Find directory where this script was executed.
use lib "$Bin/../perllib";     # Add library directory to lib path. 
use GFS_DBI;
use GFS_time;

sub get_timezone_offset
{
    my $utc_time_ref = shift;
    my $utc_time = $$utc_time_ref;
    my $timezone_code = shift;

    if (length($timezone_code) == 0)
    {
        return 0;
    }

    # first check to see if we have cached an entry for this zonecode/time
    for (my $i=0; $i <= $#timezone_cache; $i++)
    {
        my $cache_ref = $timezone_cache[$i];
        my $start_time_ref = $cache_ref->[1];
        my $end_time_ref = $cache_ref->[2];
        if ($cache_ref->[0] eq $timezone_code &&
            $utc_time->seconds_after($$start_time_ref) >= 0 &&
            $utc_time->seconds_after($$end_time_ref) <= 0)
        {
            return $$cache_ref[3];
        }
    }

    my $utc_time_text = $utc_time->as_text("%Y-%m-%d %H:%M:%S");
    my $query = 
         "select start_time, end_time, utc_offset, abbrev, isdst from " .
         "timezones " .
         "where timezone_code = '$timezone_code' " .
         " and start_time <= '$utc_time_text' " .
         " and end_time >= '$utc_time_text' ";

# printf( "%s\n", $query);

    my $dbh = GFS_DBI->connect();
    if (!defined($dbh)) {die "Could not connect to database server\n"};

    my $sth = $dbh->prepare($query);
    if (!$sth) {die "Error preparing database query: ", $dbh->errstr, "\n";}

    $sth->execute();
    my $s_idx = 0;
    my $info_idx = 0;
    my $row_ref = $sth->fetchrow_arrayref;

    if ($row_ref)
    {
        my $start_time = new GFS_time($$row_ref[0]);
        my $end_time = new GFS_time($$row_ref[1]);
        my $abbrev = $$row_ref[3];
        $abbrev =~ s/ *$//;  
        my $record_ref = [ $timezone_code, 
                \$start_time, 
                \$end_time,
                $$row_ref[2], $abbrev, $$row_ref[4] ];
        $timezone_cache[++$#timezone_cache] =  $record_ref;
        return $$row_ref[2];
    }
    else
    {
        return 0;
    }
}

1;
