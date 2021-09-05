use FindBin qw($Bin);   # Find directory where this script was executed.
use lib "$Bin/";     # Add library directory to lib path.
use strict;
use GFS_time;
use Data::Dumper;

my $bin_dir = "/data/gfs/v10/bin";
my $fcst_dir = "/Users/mustafaalogaidi/Desktop/TWC/Perl_Main_Script";
my $fcst_file = "$fcst_dir/mslp.txt";
my $HOST = "myLapTop";
# Read the forecast file
my $numstations=0;
my $hournum = 0;
my @id;
my @data;
my @pmsl;
my $s=0;
my $i=0;

# Time/Date Strings
my $today = new GFS_time;
my $yyyy = $today->as_text("%Y");
my $mm = $today->as_text("%m");
my $dd = $today->as_text("%d");
my $yyyymmdd = $yyyy . $mm . $dd;
my $inputdate = "$yyyy-$mm-$dd";

print Dumper $today;
print "\$today = $today\n";
print "\$yyyy = $yyyy\n";
print "\$mm = $mm\n";
print "\$dd = $dd\n";
print "\$yyyymmdd = $yyyymmdd\n";
print "\$inputdate = $inputdate\n";

my $validtime = new GFS_time("$inputdate 00:00:00");
print "\$validtime = $validtime\n";
print Dumper $validtime;
my $initstring = $today->as_text("%Y") .
	    "-" . $today->as_text("%m") .
	    "-" .$today->as_text("%d") .
	    " " . $today->as_text("%H:%M:%S");

my $param_code = 19;
my $fcst_source = 3;


open FCSTFILE, "<$fcst_file";
while (<FCSTFILE>)
{
    @data = split;
    #print "\@data = @data\n";
    $i=0;
    $id[$s] = shift(@data);
    #print "\$id[\$s] = $id[$s]\n";
    foreach my $d (@data)
    {
	     $pmsl[$s][$i] = $d;
       #print "\$pmsl[$s][$i] = $pmsl[$s][$i]\n";
	     $i++;
    }
    $s++;
}

$numstations = $s - 1;
my $numhours = $i;
close FCSTFILE;

print"\$s = $s\n";
print"\$numstations = $numstations\n";
print"\$i = $i \n";
print"\$numhours = $numhours\n";

# Create the sql file
my $sql_file = "$fcst_dir/mslp.sql";
print "\$sql_file = $sql_file\n";
open SQLFILE, ">$sql_file\n";
printf SQLFILE "delete from official_edits where parameter_code=19;";
for(my $i = 0; $i < $numhours; $i++)
{
    # Construct the valid time
    my $validstring = $validtime->as_text("%Y") .
	"-" . $validtime->as_text("%m") .
	"-" .$validtime->as_text("%d") .
	" " . $validtime->as_text("%H:%M:%S");

    for(my $s = 0; $s <= $numstations; $s++)
    {
	# Construct the sql statement
	my $query = "Insert into official_edits values($id[$s],'$validstring','$initstring',$param_code,$pmsl[$s][$i],$fcst_source);\n";
  #print "\$query = $query\n";
  printf SQLFILE $query;
    }
    $validtime->add_seconds(3600);
    print "\$validstring = $validstring\n";
}
close SQLFILE;
