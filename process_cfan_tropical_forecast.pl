my $ForecastHour = '12';

my $HOST = ('Mustafas-MacBook-Air.local');
my $GFS_BASE = ('/data/gfs/v10');
my $product_dir = "/data/gfs/v10/text_products";
my $data_dir = "/data/cfan";
my $login_user = "WSI_Data";
my $login_pass = "CloudsAndSun!#";
my $is_primary=`/home/gfs/bin/gfs_primary`;

my %params_of = (
	"15daytcprob_m3" => "15daytcprob_m3",
	"bydaytcprob_m3" => "bydaytcprob_m3",
        "bydaytcprob_m1" => "bydaytcprob_m1",
        "15daytcprob_m1" => "15daytcprob_m1",
	);

my %GFS_prods = (
	"15daytcprob_m3" => "15DAYTC",
        "bydaytcprob_m3" => "BYDAYTC",
        "bydaytcprob_m1" => "BYDAYNCTC",
	"15daytcprob_m1" => "15DYNCTC",
        );

my @models = qw(ECM GFS);
my @regions = qw(ATL WNP);

my $validdate = `date +%Y%m%d`; chomp $validdate;

my $datestr = "${validdate}${ForecastHour}";
my @params = keys %params_of;

print "\@models = @models\n";
print "\@regions = @regions\n";
print "\$validdate = $validdate\n";
print "\$datestr = $datestr\n";
print "\@params = @params\n";

foreach my $param (@params)
{
	foreach my $model (@models)
	{
		foreach my $region (@regions)
		{
      my $numTries = 0;
      my $FileNotFound = "";

      if (($model eq "GFS" || $param =~ /m3/) && ($region eq "WNP"))
      {
        next;
      }


      my $filename = "CFAN_${datestr}_${region}_${model}_${param}.nc";
      print"\$filename = $filename\n";
      if ($region eq "WNP")
      {
        $filename =~ s/_m1//;
        print"region equal to WNP and \$filename = $filename\n";
      }




    }
	}
}
