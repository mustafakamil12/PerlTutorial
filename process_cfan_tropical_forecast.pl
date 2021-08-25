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

	);

my %GFS_prods = (
	"15daytcprob_m3" => "15DAYTC",

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

      my $url = "https://www.cfanclimate.com/PULL/WSI/$filename";
      print "\$url = $url\n";
      print"curl -o /dev/null --silent --max-time 3 -u $login_user:$login_pass --head --write-out '%{http_code}' $url\n";
      my $status_code = `curl -o /dev/null --silent --max-time 3 -u $login_user:$login_pass --head --write-out '%{http_code}' $url`;
      print "\$status_code = $status_code\n";
      my $file_found;

      if ($status_code eq "200")
      {
        $file_found = 1;
      }
      else
      {
        $file_found = 0;
      }

      print "============================\n";
      print "start section testing Aug-24\n";
      print "\$file_found = $file_found\n";
      print "\$numTries = $numTries\n";


      while ($file_found == 0 && $numTries <= 2)
      {

        print STDERR "The file $filename has not yet arrived, sleeping 1 minute\n";
        print "will sleep for 60\n";
        sleep 1;
        print "curl -o /dev/null --silent --max-time 3 -u $login_user:$login_pass --head --write-out '%{http_code}' $url\n";
        $status_code = `curl -o /dev/null --silent --max-time 3 -u $login_user:$login_pass --head --write-out '%{http_code}' $url`;

                          if ($status_code eq "200")
                          {
                                  $file_found = 1;
                          }

        $numTries++;

        if ($numTries > 2)
        {
          print STDERR "The file $filename has not yet arrived after 60 minutes...moving on\n";
          $FileNotFound = "no";

          open MAILMSG,"| mail -s \"CFAN Tropical file has not yet arrived after 60 minutes on $HOST\" godric.phoenix\@gmail.com";
              print MAILMSG "$filename missing on $HOST\n";
              close MAILMSG;

          next;
        }
        print "reach out to the end of first while...\n";

      }# end first while

      next if ($FileNotFound eq "no");

      print "Processing the file $filename\n";
      my $downloaded = 0;
      while ($downloaded == 0) {
        my $err = system("curl -f -o ${data_dir}/${filename} -u ${login_user}:${login_pass} $url");
            print "\$err = $err\n";
            $err = $err >> 8;
            if ($err != 0) {
                print STDERR "error in getting file $err $url\n";
                sleep(3);
            } else {
                $downloaded = 1;
            }
      }


    }
	}
}
