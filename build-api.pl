$lat =  39.05;
$lon =  -84.6667;
$start_date = "06/23/2021";
$past_date = "06/21/2021";
$api = "http://api.weatheranalytics.com/v2/wsi/metar/[${lat},${lon}]?startDate=${past_date}&endDate=${start_date}&interval=hourly&units=imperial&format=xml&userKey=4449f2f578c59aa4eb638a9c5d39ec52&time=lwt&limit=25";

print "\$api = $api\n";
