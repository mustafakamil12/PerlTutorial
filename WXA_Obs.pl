#!/usr/bin/perl

#----------------------------------------------------------
#
#
#
#
#----------------------------------------------------------


use strict;
use warnings;

use FindBin qw($Bin);   # Find directory where this script was executed.
use lib "$Bin/../perllib";     # Add library directory to lib path. 

use HTTP::Request;
use XML::Simple;
use GFS_DBI;
use Data::Dumper;
use Date::Calc;
use LWP::UserAgent;


#inputs
my $frequency = shift;

#Setup Config
my $GFS_BASE = $ENV{'GFS_BASE'};
my $output_dir = "${GFS_BASE}/text_products";
my $dbh = GFS_DBI->connect();
my $station_list_data;

my $site_data;
my $customer_data;

#Fetch list of customer names, and customer site lists
my $customer_query = "select customer_code, product_name, post_proc, station_list from cleaned_obs_config where frequency = \'${frequency}\' and resolution = 'hourly' and active = 'y'";

my $sth = $dbh->prepare($customer_query) 
    or die "Error preparing database query: ", $dbh->errstr, "\n";

$sth->execute 
    or die "Error executing: ", $sth->errstr, "\n"; 


while (my $ref = $sth->fetchrow_hashref)
{
    print Dumper($ref);
    my $customer = $ref->{'customer_code'};
    my $product_name = $ref->{'product_name'};
    my $station_list = $ref->{'station_list'};
    my $frequency = $ref->{'frequency'};
    my $post_proc = $ref->{'post_proc'};
  
    $customer_data->{$customer}{$product_name}{'station_list'} = $station_list;
    $customer_data->{$customer}{$product_name}{'post_proc'} = $post_proc;

}

#print Dumper($customer_data); die;

#Setup Dates
my $past_date;
my $start_date = GetPastDateUTC(0);  

if ($frequency eq 'weekly')
{
    $past_date = GetPastDateUTC(8);
   
}
elsif ($frequency eq 'daily')
{
    $past_date = GetPastDateUTC(2);
}

#Foreach Customer name create 
foreach my $customer(keys %{$customer_data})
{
    foreach my $product(keys %{$customer_data->{$customer}})
    {
        my $station_list = $customer_data->{$customer}->{$product}->{'station_list'};

        my $site_query = "select fsl.wsi_code, icao_code,name,latitude,longitude, list_order from full_station_list fsl, station_lists sl, station_list_names sln where fsl.wsi_code=sl.wsi_code and sl.list_id = sln.list_id and sln.list_name = '$station_list'  order by sl.list_order";
        print "DEBUG: $site_query\n";
        $sth = $dbh->prepare($site_query) 
            or die "Error preparing database query: ", $dbh->errstr, "\n";
        
        $sth->execute 
            or die "Error executing: ", $sth->errstr, "\n"; 
        
        
        while (my $ref = $sth->fetchrow_hashref)
        {
            #print Dumper($ref);
            my $wsi_code = $ref->{'wsi_code'};
            my $icao_code = $ref->{'icao_code'};
            my $name = $ref->{'name'};
            my $lat = $ref->{'latitude'};
            my $lon = $ref->{'longitude'};
            my $list_order = $ref->{'list_order'};
            
            $site_data->{$wsi_code}{'metadata'} = $ref;
            $site_data->{$wsi_code}{'APICall'} =  "http://api.weatheranalytics.com/v2/wsi/metar/[${lat},${lon}]?startDate=${past_date}&endDate=${start_date}&interval=hourly&units=imperial&format=xml&userKey=4449f2f578c59aa4eb638a9c5d39ec52&time=lwt&limit=25";
            print "DEBUG:  $customer $product $wsi_code: $site_data->{$wsi_code}{'APICall'}\n";
            #print "$customer $station_list $list_order $wsi_code\n";
            $customer_data->{$customer}->{$product}->{'stations'}->{$list_order} = "$wsi_code";
        }
    }
}

#Make WXA Call to grab data for all the sites
#depending on how its returned add it to site_data
#complete API call with site specific info

##FOR NOW going to loop over each site and call the api for each since there isn't a way to call with multiple lat lons
foreach my $site(keys %{$site_data})
{
   
    my $call = $site_data->{$site}{'APICall'};
    my $agent = LWP::UserAgent->new(env_proxy => 1, keep_alive => 1, timeout => 30);
    my $header = HTTP::Request->new(GET => $call );
    my $request = HTTP::Request->new('GET',$call, $header);
    
    my $site_pulled_succesfully = 0;
    my $num_attempts = 0;
    while ($num_attempts < 5)
    {
        my $response = $agent->request($request);
        
        print "Making API Call attempt: " .  ($num_attempts+1) . "\n";
        print "DEBUG:: Call: $call\n";
        if ( $response->is_success )
        {
            # Placeholder for testing
            $site_pulled_succesfully = 1;
            ParseWXA_XML($site, $response->content);            
            print "Complete call for $site ${past_date} - ${start_date}\n";
            last;
        }
        else
        {
            $num_attempts++;
            print "Error calling Weather Analytics for $site ${past_date} - ${start_date}\n";
            sleep 2;  #Don't overwhelm the API its fragile as it is
        }
    }
}

#For each customer create file and send
#using the site_name from customer loop over the customer_data to create the csv and send
#
foreach my $customer(keys %{$customer_data})
{
    foreach my $product(keys %{$customer_data->{$customer}})
    {
        
        my $outfile = "${output_dir}/$product";

        open ( OUTFILE, ">$outfile" );

        #HEADER
        print OUTFILE "SiteName,ID,FormattedValidTime,DateHrLwt,DateHrGmt,Tsfc,Rh,Tapp,Twc,DewPt,CldCov,PcpPrevHr,WindSpd,WindDir,SfcPressure,DirNormIr,GHI,DiffuseIr\n";
        
        #loop over each station
        foreach my $site_index(sort(keys %{$customer_data->{$customer}->{$product}->{'stations'}}))
        {

            my $site_id = $customer_data->{$customer}->{$product}->{'stations'}{$site_index};
            my $site_name = $site_data->{$site_id}->{'metadata'}->{'name'};
	        my $icao = $site_data->{$site_id}->{'metadata'}->{'icao_code'};
            
            #Trim trailing white space from site name
            $site_name =~ s/\s+$//;

            #loop over each time period
            foreach my $valid_time(sort(keys %{$site_data->{$site_id}->{'obs'}}))
            {

                my @DateHrLwt_parts = split(':', FormatDate($site_data->{$site_id}->{'obs'}->{$valid_time}->{'dateHrLwt'}));
                
                my $DateHrLwt = @DateHrLwt_parts[0];
                my $DateHrGmt = FormatDate($site_data->{$site_id}->{'obs'}->{$valid_time}->{'dateHrGmt'});
		        my $FormattedValidTime = $site_data->{$site_id}{'obs'}{$valid_time};
                my $Tsfc = sprintf("%.0f",$site_data->{$site_id}->{'obs'}->{$valid_time}->{'SurfaceTemperatureFahrenheit'});
                my $Rh = $site_data->{$site_id}->{'obs'}->{$valid_time}->{'RelativeHumidity'};
                my $Tapp = sprintf("%.0f",$site_data->{$site_id}->{'obs'}->{$valid_time}->{'ApparentTemperatureFahrenheit'});
                my $Twc = sprintf("%.0f",$site_data->{$site_id}->{'obs'}->{$valid_time}->{'WindChillTemperatureFahrenheit'});
                my $dew = sprintf("%.0f",$site_data->{$site_id}->{'obs'}->{$valid_time}->{'SurfaceDewpointTemperatureFahrenheit'});
                my $CldCov = $site_data->{$site_id}->{'obs'}->{$valid_time}->{'CloudCoverage'};
                my $TWetBulb = sprintf("%.0f",$site_data->{$site_id}->{'obs'}->{$valid_time}->{'SurfaceWetBulbTemperatureFahrenheit'});
                my $PcpPrevHr = $site_data->{$site_id}->{'obs'}->{$valid_time}->{'PrecipitationPreviousHourInches'};
                my $Spd = $site_data->{$site_id}->{'obs'}->{$valid_time}->{'WindSpeedMph'};
                my $Dir = $site_data->{$site_id}->{'obs'}->{$valid_time}->{'WindDirection'};
                my $DirNormIr = $site_data->{$site_id}->{'obs'}->{$valid_time}->{'DirectNormalIrradiance'};
                my $Psfc = $site_data->{$site_id}->{'obs'}->{$valid_time}->{'MslPressure'};
                my $DnSol = $site_data->{$site_id}->{'obs'}->{$valid_time}->{'DownwardSolarRadiation'};
                my $DiffHorz = $site_data->{$site_id}->{'obs'}->{$valid_time}->{'DiffuseHorizontalRadiation'};


                print "$site_name,$icao,$valid_time,$DateHrLwt,$DateHrGmt,$Tsfc,$Rh,$Tapp,$Twc,$TWetBulb,$dew,$CldCov,$PcpPrevHr,$Spd,$Dir,$Psfc,$DirNormIr,$DnSol,$DiffHorz\n";
                print OUTFILE "$site_name,$icao,$valid_time,$DateHrLwt,$DateHrGmt,$Tsfc,$Rh,$Tapp,$Twc,$TWetBulb,$dew,$CldCov,$PcpPrevHr,$Spd,$Dir,$Psfc,$DirNormIr,$DnSol,$DiffHorz\n";

            }


            
        }



        close(OUTFILE);
   
        #run the post proc
        if ($customer_data->{$customer}->{$product}->{'post_proc'} ne "")
        {

            my $post_proc = $customer_data->{$customer}->{$product}->{'post_proc'};
            system("$GFS_BASE/formatter_post_proc/$post_proc < ${output_dir}/${product} > ${output_dir}/${product}.tmp ; mv ${output_dir}/${product}.tmp ${output_dir}/${product}");
        }

        # Send the File
        system("$GFS_BASE/bin/prod_send.pl -product $product");
        
        # Archive the Product
        system("$GFS_BASE/bin/archive_product ${output_dir}/${product}");
    }
}

#print Dumper($site_data);
#print Dumper($customer_data);

sub GetPastDateUTC
{
    my $pastDays = shift;
    my $year, my $month, my $day, my $hour, my $min, my $sec;
    ($year,$month,$day, $hour,$min,$sec) = Date::Calc::Today_and_Now();

    ($year, $month, $day) = Date::Calc::Add_Delta_Days($year, $month, $day, ($pastDays * -1));

    return "$month/$day/$year";
}

sub GetTodaysDateUTC
{
    my $year, my $month, my $day, my $hour, my $min, my $sec;
    ($year,$month,$day, $hour,$min,$sec) = Date::Calc::Today_and_Now();

    return "$month/$day/$year";
}

sub ParseWXA_XML
{
    my $site_id = shift;
    my $data_response = shift;

    # XMLin returns a hash_ref
    my $xml_data = XMLin($data_response);
    my @weather_records;
   
    if ( defined( $xml_data->{'WeatherData'}{'Hours'}{'Hour'}))
    {
        # array of weather records hashs
        @weather_records = @{$xml_data->{'WeatherData'}{'Hours'}{'Hour'}};
    }	


    for my $record ( @weather_records )
    {
        my %record_hash = %{$record};
        my $valid_time = ParseFormattedDateTime( $record_hash{'dateHrGmt'} );

        $site_data->{$site_id}{'obs'}{$valid_time} = $record;
   
    }

}


sub ParseFormattedDateTime
{

    #OLD: 10/17/2015 5:00:00 AM ->  2015-10-17T05:00:00Z

    #NEW1: 2015-10-17 05:00:00.0 ->  2015-10-17T05:00:00Z
    #NEW2: 10/20/2015 05:00:00

    my $date_str = $_[0];

    # check if the input is in the format of "2015-10-17 05:00:00.0"
    if (index($date_str, "-") != -1)
    {
        $date_str =~ s/.(\d+)$/Z/;
        $date_str =~ s/(\s)/T/;
        return $date_str;
    }
    #otherwise, the format is "10/20/2015 05:00:00"

    my @time_parts = split(" ",$date_str);
    my $date = "";
    my $time = $time_parts[1];
    
    my @date_parts = split("/",$time_parts[0]);
    
    my $mm = sprintf("%02d",$date_parts[0]);
    my $dd = sprintf("%02d",$date_parts[1]);
    my $yyyy = $date_parts[2];
            
    return "${yyyy}-${mm}-${dd}T${time}Z";
}

sub FormatDate
{

    #OLD: 10/17/2015 5:00:00 AM
    #NEW: 2015-10-17 00:00:00.0

    my $raw_date = shift;

    my $formatted_date;

    if ($raw_date =~ m/(\d+)-(\d+)-(\d+) (\d+):(\d+):(\d+)/)
    {
        my $mm = sprintf("%02d", $2);
        my $dd = sprintf("%02d", $3);
        my $yyyy = $1;
        
        my $hh = $4;

        $hh =  sprintf("%02d", $hh);
        #print "$1 , $2, $3, $4, $5, $6, $7\n";
       
        $formatted_date = "${yyyy}/${mm}/${dd} ${hh}";
    }
    else
    {
        $formatted_date = "$raw_date";
    }
    return $formatted_date;

}
