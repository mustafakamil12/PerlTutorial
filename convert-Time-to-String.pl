use POSIX qw(strftime);

$build_time =  strftime("%Y-%m-%d %H:%M:%S",gmtime(time()));

print "\$build_time: $build_time\n";

$time = time;
print "\$time: $time\n";
$test = gmtime(time());
print "$test \n";
