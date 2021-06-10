#!/usr/bin/perl

open(TOTALS,"/Users/mustafaalogaidi/Desktop/MyWork/TutorialsPoint-Perl/MISSGEDD_TOTALS");

$count = 0;

while (<TOTALS>)
{
    chop $_;
    #print"\$_ after chop = $_\n";
    @vals = split (/ /,$_);
    #print "\@vals = @vals\n";
    #print "\vals[0] = $vals[0]\n";
    #print "\vals[1] = $vals[1]\n";
    #print "\vals[2] = $vals[2]\n";
    if ($vals[1] ne "")
    {

        $month{$vals[0]} = $vals[1];
        $year{$vals[0]} = $vals[2];
        $station[$count] = $vals[0];

        #print "\$month{$vals[0]} = $month{$vals[0]}\n";
        #print "\$year = $year\n";
        #print "\$station = $station\n";

        print "Read in $station[$count]/$month{$vals[0]}/$year{$vals[0]}\n";
        $count++;
        #print "count = $count\n";
    }
}

close TOTALS;

open (OBS,"/Users/mustafaalogaidi/Desktop/MyWork/TutorialsPoint-Perl/MISSGEDD");

while (<OBS>)
{
    chop $_;
    @vals = split(/	/,$_);
    $month{$vals[0]} += $vals[1];
    $year{$vals[0]} += $vals[1];
    print"\$month{$vals[0]} += $vals[1]\n";
    print"\$year{$vals[0]} += $vals[1]\n";
    print "Read in $vals[0]:$vals[1]\n";
}

close OBS;

open (OUTFILE,">/Users/mustafaalogaidi/Desktop/MyWork/TutorialsPoint-Perl/MISSGEDD_TOTALS");

for ($i = 0; $i < $count; $i++)
{
    print "$station[$i]	$month{$station[$i]}	$year{$station[$i]}\n";
    @datearr = localtime;
    print"@datearr\n";
    print"--------------\n";
    print"\$datearr[3] = $datearr[3]\n";
    print"\$datearr[4] = $datearr[4]\n";

    print"\$month{$station[$i]} = $month{$station[$i]}\n";
    print"\$year{$station[$i]}  = $year{$station[$i]}\n";
    print"\$station[$i] = $station[$i]\n";

    if ($datearr[3] == 1)
    {
        $month{$station[$i]} = 0;
	   if ($datearr[4] == 6)
	   {
	      $year{$station[$i]} = 0;
	   }
    }

    print OUTFILE "$station[$i]	$month{$station[$i]}	$year{$station[$i]}\n";
}

close OUTFILE;
