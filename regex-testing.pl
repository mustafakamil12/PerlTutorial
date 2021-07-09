$time_interval = "+1";
 $seconds = 0;
 $months  = 0;
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
     $years = $1;
     $mons = $2;
     $days = $3;
     $hours = $4;
     $minutes = $5;
     $secs = $6;

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

print "$seconds\n";
print "$months\n";
