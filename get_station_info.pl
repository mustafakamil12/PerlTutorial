sub get_station_info {
  my $info_type = shift;
  my $format =  $#_>=0 ? shift : "";
  my $s_idx = $#_>=0 ? shift : $station_idx;
  my $missing = shift;
  my $capitalize = $info_type =~ s/cap_//;

  # for now, timezone is special since we need it for first pass
  # proccessing, we load it prior to the first pass. all other
  # information is only required in the second pass, so during
  # the first pass we keep track of what we will need in the second.
  if ($first_pass)
  {
    if (length($station_info_hash{$info_type}) == 0)
    {
        $station_info_list[$#station_info_list+1] = $info_type;
        $station_info_hash{$info_type} = $#station_info_list;
    }
    if ($info_type == "timezone_code")
    {
        return $station_info[$s_idx];
    }
    return "";
  }

  my $info_idx = $station_info_hash{$info_type};

  my $value = $station_info[$s_idx * ($#station_info_list+1) + $info_idx];

  if (defined($missing) and ! defined($value))
  {
      return $missing;
  }
  #
  # split up into words, capitalize if necessary and put back into a string.
  # (this will remove trailing blanks and change multiple blanks into
  # single blanks).
  #
  my @words = split(" ", $value);
  if ($capitalize)
  {
      for (@words) {$_ = ucfirst lc};
  }
  $value = join " ",@words;
  length($format)== 0 ? $value : sprintf($format, $value);
}

sub STATION_FAA { get_station_info("faa_code", @_); }

$Out_Put = STATION_FAA();

print "\$Out_Put = $Out_Put \n";
