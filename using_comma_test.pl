use JSON;

$dist_type = "Attachment";
$prod_id = "USEFCST";
if (uc($dist_type) eq uc("Email") || uc($dist_type) eq uc("Attachment"))
{
    # Use ssh to call a script hosted on energy-generic1. The script returns json
    # that contains the addresses.
    print("Retrieving addresses.\n");
    print '`ssh -l op energy-generic1 \"~/api/call_api.pl $prod_id\"`'."\n";
    #$json_str = `ssh -l op energy-generic1 \"~/api/call_api.pl $prod_id\"`;
    $json_str = '[{"AddressId":"3e836a7f-d3b5-4a59-a78d-338313822e54","Type":"NA","Address":"eric.watkins@usenergygrp.com,mustafa.k.alogaidi@gmail.com"}]';
    $json_hash = decode_json($json_str);
    @addresses;
    for my $obj (@$json_hash) {
        push(@addresses, $obj->{Address});
    }

    # Prepend the comma-delimited email addresses to what came from the
    # address field in the database.
    if (uc($dist_type) eq uc("Email"))
    {
        $address = join(',', @addresses);
    }
    else
    {
        $address = join(',', @addresses) . " " . $address;

    }
}

print "\$address = $address\n";
print "\@addresses = @addresses \n";
