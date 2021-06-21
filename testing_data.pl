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
