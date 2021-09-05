open (STATIONS,"/Users/mustafaalogaidi/Desktop/MyWork/TutorialsPoint-Perl/ukgfs.stn");

@stats = <STATIONS>;
print "\@stats = @stats";
chop @stats;
print "\@stats = @stats";

for ($i = 0; $i <= $#stats; $i++)
{
    @stat_vals = split(/,/,$stats[$i]);
    print "\@stat_vals = @stat_vals\n";
    $wsi_code = $stat_vals[0];
    $icao_code = $stat_vals[1];

    print "\$wsi_code = $wsi_code\n";
    print "\$icao_code = $icao_code\n";
}
