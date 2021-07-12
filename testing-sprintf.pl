$hours   = 12;
$minutes = 24;
$seconds = 30;
$utc_offset_str = sprintf("%+2.2d:%2.2d:%2.2d",$hours, $minutes, $seconds);
print"\$utc_offset_str = $utc_offset_str\n";

$GFS_time::ISO_FORMAT = "%Y-%m-%d %H:%M:%S%z";

$fmt = $GFS_time::ISO_FORMAT;
print "\$fmt = $fmt\n";
$fmt =~ s/\%z/$utc_offset_str/g;
print "\$fmt = $fmt\n";
print "\$utc_offset_str = $utc_offset_str\n";
