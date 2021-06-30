use JSON::MaybeXS qw(encode_json decode_json);
use Data::Dumper;

$customer_data_json =  '{"NOEL": {"NOELTESTPROD": {"station_list": "NOELTEST", "post_proc": ""}, "NOELTESTPROD2": {"station_list": "NOELTEST2", "post_proc": ""}}, "GBE": {"GBESOLAROBS": {"station_list": "gbe_solar_stn", "post_proc": "proc_gbe_solar", "stations": {"0": 17045, "1": 17912, "2": 17447}}}}';

$site_data_json = '{"17045": {"metadata": [17045, "KCVG", "COVINGTON", 39.05, -84.6667, 0],"APICall": "http://api.weatheranalytics.com/v2/wsi/metar/[39.05,-84.6667]?startDate=06/27/2021&endDate=06/29/2021&interval=hourly&units=imperial&format=xml&userKey=4449f2f578c59aa4eb638a9c5d39ec52&time=lwt&limit=25"}}';

$customer_data = decode_json $customer_data_json;
#print Dumper($customer_data);

$site_data = decode_json $site_data_json;
#print Dumper($site_data);

$customer = "GBE";
$product = "GBESOLAROBS";
$site_id = "17045";
$site_name = $site_data->{$site_id}->{'metadata'};
print Dumper($site_name)
