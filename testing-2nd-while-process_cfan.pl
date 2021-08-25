my $HOST = ('Mustafas-MacBook-Air.local');
my $GFS_BASE = ('/data/gfs/v10');
my $product_dir = "/data/gfs/v10/text_products";
my $data_dir = "/data/cfan";
my $login_user = "WSI_Data";
my $login_pass = "CloudsAndSun!#";
my $is_primary=1;

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
my $model = 'GFS';
my $region = 'WNP';

my $validdate = `date +%Y%m%d`; chomp $validdate;

my $datestr = "${validdate}${ForecastHour}";
my @params = keys %params_of;
$url = "https://www.cfanclimate.com/PULL/WSI/CFAN_2021082512_ATL_ECM_15daytcprob_m3.nc";

print "Processing the file $filename\n";

=pod
my $downloaded = 0;
while ($downloaded == 0) {
  my $err = system("curl -f -o ${data_dir}/${filename} -u ${login_user}:${login_pass} $url");
      print "\$err = $err\n";
      $err = $err >> 8;
      print "\$err after shift with 8 = $err\n";
      if ($err != 0) {
          print STDERR "error in getting file $err $url\n";
          sleep(3);
      } else {
          $downloaded = 1;
      }
}

=cut

my $product = "${datestr}_${region}_${model}_${params_of{$param}}.nc";

print "\$product = $product\n";

my $final;
if ($region eq "WNP")
{
  $final = "CFANWP${model}${ForecastHour}_${GFS_prods{$param}}";
  print "\$final = $final\n";
}
else
{
  $final = "CFAN${region}${model}${ForecastHour}_${GFS_prods{$param}}";
  print "\$final = $final\n";
}


print "Moving the file $filename to $product\n";
system("cp -f $data_dir/$filename $data_dir/$product");

print "Moving the file $product to $final\n";
system("cp -f $data_dir/$product $product_dir/$final");


if ($region eq "ATL")
{
  print "Transferring $data_dir/$product to energy-research\n";
  if ( $is_primary==1 ) {
    system("scp $data_dir/$product op\@energy-research1:/archive/real_time/cfan/TCs");
  }
}

=pod
# Send the File
      system("$GFS_BASE/bin/prod_send.pl -product $final");

      # Archive the Product
system("$GFS_BASE/bin/archive_product $product_dir/$final");
=cut
