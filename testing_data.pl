use Data::Dumper;

$customer_data;
$customer = 'NOEL';
$product_name = 'NOELTESTPROD';
$station_list = 'NOELTEST';
$frequency = 'daily';
$post_proc = '';


$customer_data->{$customer}{$product_name}{'station_list'} = $station_list;
$customer_data->{$customer}{$product_name}{'post_proc'} = $post_proc;
print Dumper ($customer_data);
print("\n");

$customer = 'NOEL';
$product_name = 'NOELTESTPROD2';
$station_list = 'NOELTEST2';
$frequency = 'daily';
$post_proc = '';


$customer_data->{$customer}{$product_name}{'station_list'} = $station_list;
$customer_data->{$customer}{$product_name}{'post_proc'} = $post_proc;
print Dumper ($customer_data);
print("\n");

$customer = 'GBE';
$product_name = 'GBESOLAROBS';
$station_list = 'gbe_solar_stn';
$frequency = 'daily';
$post_proc = '';


$customer_data->{$customer}{$product_name}{'station_list'} = $station_list;
$customer_data->{$customer}{$product_name}{'post_proc'} = $post_proc;
print Dumper ($customer_data);
print("\n");

foreach my $customer(keys %{$customer_data})
{
  print "\$customer = $customer \n";
  foreach my $product(keys %{$customer_data->{$customer}})
  {
    print "\$product = $product \n";
    my $station_list = $customer_data->{$customer}->{$product}->{'station_list'};
    print "\$station_list = $station_list \n";
    print $site_query = "select fsl.wsi_code, icao_code,name,latitude,longitude, list_order from full_station_list fsl, station_lists sl, station_list_names sln where fsl.wsi_code=sl.wsi_code and sl.list_id = sln.list_id and sln.list_name = '$station_list'  order by sl.list_order\n";
    my $site_query = "select fsl.wsi_code, icao_code,name,latitude,longitude, list_order from full_station_list fsl, station_lists sl, station_list_names sln where fsl.wsi_code=sl.wsi_code and sl.list_id = sln.list_id and sln.list_name = '$station_list'  order by sl.list_order";
  }
}
