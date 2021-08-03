$process_limit = 1;
@process_slots = (-1,-1,-1,-1);
$TIMEOUT_VALUE = 5;


for my $iteration (0..$TIMEOUT_VALUE)
{
    # First loop
    print "inside first loop \n";
    print "\$iteration = $iteration\n";
    my $num_free = 0;
    for my $process_slot (0..$process_limit-1)
    {
        # Second loop
        print "inside second loop \n";
        print "\$process_slot = $process_slot \n";
        if ($process_slots[$process_slot] < 0)
        {
            print "\$process_slots[$process_slot] = $process_slots[$process_slot] \n";
            $num_free++;
            next;
        }
        print "after next\n";
        my $pid = waitpid($process_slots[$process_slot], &WNOHANG);
        my $status = $?;
        if ($pid != 0)
        {
            process_complete($process_slot, $status);
            $process_slots[$process_slot] = -1;
            $num_free++;
        }
    }
    print "checkin \$num_free = $num_free\n";
    if ($num_free >= $num_required)
    {
        print "\$num_free = $num_free\n";
    }
    sleep 1;
}
