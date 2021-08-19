
my $bin_dir = "/data/gfs/v10/bin";
my $fcst_dir = "/Users/mustafaalogaidi/Desktop/MyWork/TutorialsPoint-Perl";
$fcst_file = "$fcst_dir/mslp.txt";
$HOST = "myLapTop";
# Read the forecast file
my $numstations=0;
my $hournum = 0;
my @id;
my @data;
my @pmsl;
my $s=0;
my $i=0;
open FCSTFILE, "<$fcst_file";
while (<FCSTFILE>)
{
    @data = split;
    print "\@data = @data\n";
    $i=0;
    $id[$s] = shift(@data);
    print "\$id[\$s] = $id[$s]\n";
    foreach my $d (@data)
    {
	     $pmsl[$s][$i] = $d;
       print "\$pmsl[$s][$i] = $pmsl[$s][$i]\n";
	     $i++;
    }
    $s++;
}
