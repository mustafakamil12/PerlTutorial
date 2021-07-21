$format_filename = "frmt_bofa_hourly_fcst";
$config_options = "-reltime 9";
$perl_formatter = ($format_filename =~ /\.pl$/);
$config_options = ($config_options =~ /-reltime +(-?[0-9]+)/);
-gfs(.+)$

print "\$perl_formatter = $perl_formatter \n";
print "\$config_options = $config_options \n";
