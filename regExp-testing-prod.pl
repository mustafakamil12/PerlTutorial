$pp = "11 .22";
$pp =~ /([^ ]*) (.*)/;

$pp_com = $1;
$pp_param = $2;

print "\$pp = $pp \n";
print "\$pp_com = $pp_com \n";
print "\$pp_param = $pp_param \n";
