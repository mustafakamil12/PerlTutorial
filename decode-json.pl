#!/usr/bin/perl
use JSON;
use Data::Dumper;

@myArr = (1,2,3);
print "\@myArr: @myArr\n";
my $no = push(@myArr, 5);

print "\@myArr: @myArr\n";
print "\$no: $no\n";

$json_str = '{"Address":"Iraq","Address":"Jordan","Address":"Egypt","Address":"Syria","Address":"Libya"}';
print "\$json_str: $json_str\n";

my $json_hash = decode_json($json_str);
$ref_type = ref($json_hash);

print "type of \$json_hash: $ref_type\n";
print Dumper($json_hash);

my @addresses;
for my $obj ($json_hash) {
    push(@addresses, $obj->{Address});
    #print "\$obj: $obj\n";
}

print "\@addresses: @addresses\n";
