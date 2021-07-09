package GFS_time;
sub seconds_after
{
    my $self   = shift;
    my $time_t = $self->{'time_t'};
    if ($time_t == -1)
    {
        return 0;
    }

    my $other = shift;
    my $other_time_t = $other->{'time_t'};
    if ($other_time_t == -1)
    {
        return 0;
    }

    print "\$time_t = $time_t \n";
    print "\$other_time_t = $other_time_t \n";
    return $time_t - $other_time_t;
}

$roni = GFS_time::seconds_after(12,24);

print "\$roni = $roni\n";
