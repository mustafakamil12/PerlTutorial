#!/usr/bin/perl

use XML::Simple;
use Data::Dumper;
use Date::Calc;

$site_id = 123;
$data_response = "/Users/mustafaalogaidi/Desktop/TWC/Perl_Main_Script/days4.xml";

# XMLin returns a hash_ref
$xml_data = XMLin($data_response);
print Dumper ($xml_data);
print "\$xml_data = $xml_data->{'WeatherData'}{'Hours'}{'Hour'}\n";

@weather_records;

if ( defined($xml_data->{'WeatherData'}{'Hours'}{'Hour'}))
{
    # array of weather records hashs
    print "array of weather records hashs\n";
    @weather_records = @{$xml_data->{'WeatherData'}{'Hours'}{'Hour'}};
    print "\@weather_records = @weather_records\n";
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

for $record ( @weather_records )
{
    print "\%{\$record} = %{$record}\n";
    %record_hash = %{$record};
    print "\%record_hash = %record_hash \n";
    print "ParseFormattedDateTime\n";
    print "\$record_hash{'dateHrGmt'} = $record_hash{'dateHrGmt'}\n";
    $valid_time = ParseFormattedDateTime( $record_hash{'dateHrGmt'} );
    print "\$valid_time = $valid_time\n";

    $site_data->{$site_id}{'obs'}{$valid_time} = $record;
    print "site_data\n";
    print "{$site_id}{'obs'}{$valid_time}\n";

}
