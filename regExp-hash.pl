sub decode_sql_time
{
    $_[0] =~ /([0-9][0-9]*)-([0-9][0-9]*)-([0-9][0-9]*) ([0-9][0-9]*):([0-9][0-9]*):([0-9][0-9]*)/;
    print "{$5,$4,$3,$2,$1}\n";
}

$date = "10-09-1989 11:15:01";
$result = decode_sql_time($date);
print "\$result = $result\n";
