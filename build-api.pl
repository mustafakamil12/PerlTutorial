use HTTP::Request;
use XML::Simple;

use Data::Dumper;
use Date::Calc;
use LWP::UserAgent;

$lat =  39.05;
$lon =  -84.6667;
$start_date = "06/23/2021";
$past_date = "06/21/2021";
$api = "http://api.weatheranalytics.com/v2/wsi/metar/[${lat},${lon}]?startDate=${past_date}&endDate=${start_date}&interval=hourly&units=imperial&format=xml&userKey=4449f2f578c59aa4eb638a9c5d39ec52&time=lwt&limit=25";

print "\$api = $api\n";

my $call = $api;
my $agent = LWP::UserAgent->new(env_proxy => 1, keep_alive => 1, timeout => 30);
my $header = HTTP::Request->new(GET => $call );
my $request = HTTP::Request->new('GET',$call, $header);

print "\$request = $request\n";
my $site_pulled_succesfully = 0;
my $num_attempts = 0;
