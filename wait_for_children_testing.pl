$process_limit = 1;
@process_slots = (-1, -1, -1, -1);
$TIMEOUT_VALUE = 180;


sub wait_for_children
{

    my $num_required = shift;
    print "\$num_required = $num_required \n";
    print "\$process_limit = $process_limit \n";
    print "\$TIMEOUT_VALUE = $TIMEOUT_VALUE \n";
    if ($num_required > $process_limit)
    {
        $num_required = $process_limit;
    }

    print "\$num_required = $num_required \n";

    for my $iteration (0..$TIMEOUT_VALUE)
    {
        print "\$iteration = $iteration\n";
        my $num_free = 0;
        for my $process_slot (0..$process_limit-1)
        {
            print "\$process_slot = $process_slot\n";
            print "\$process_slots[\$process_slot] = $process_slots[$process_slot]\n";
            #$process_slots[$process_slot] = 1;
            if ($process_slots[$process_slot] < 0)
            {
                $num_free++;
                print "\$num_free = $num_free \n";
                next;
            }
            my $pid = waitpid($process_slots[$process_slot], &WNOHANG);
            my $status = $?;
            print "\$pid = $pid\n";
            print "\$status = $status\n";
            if ($pid != 0)
            {
                process_complete($process_slot, $status);
                $process_slots[$process_slot] = -1;
                $num_free++;
            }
        }
        print "$num_free >= $num_required\n";
        if ($num_free >= $num_required)
        {
            return $num_free;
        }
        sleep 1;
    }

    return 0;
}

$result = wait_for_children(1);
print "\$result = $result \n";
