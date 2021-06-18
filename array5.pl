
@weather_records = ("1","2","3");
for $record ( @weather_records )
    {
        %record_hash = %{$record};
        print "\%{\$record} = %{$record}\n";
        print "\%record_hash = %record_hash\n";
        print "\$record_hash{'dateHrGmt'} = $record_hash{'dateHrGmt'}"
    }
