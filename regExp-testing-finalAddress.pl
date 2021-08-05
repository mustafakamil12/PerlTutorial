$final_address = "godric.phoenix@gmail.com";
#$final_address =~ s/#TZ=(\w*)#//;
$final_address =~ s/\$/\\\$/g;
$final_address =~ s/ (\S*[\$#]\S*) / '"'"'"$1"'"'"' /g;

print "\$final_address = $final_address\n";
