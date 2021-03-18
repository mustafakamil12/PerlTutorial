sub format_date_tag
{
    $_[4].$_[3].$_[2].$_[1].$_[0];
}

my @array = (1, 2, 3);
my $value = shift @array;
print "$value\n"; # will print '1'
print "@array\n";

print "--------------------------\n";

@date = [11,12,13,14,15];
$funRes=fromat_date_tag(@date) ;
print $funRes;
print format_date_tag(@date)
