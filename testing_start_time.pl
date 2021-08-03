use FindBin qw($Bin);   # Find directory where this script was executed.
print "\$Bin = $Bin\n";
#use lib "$Bin/../perllib";     # Add library directory to lib path.
use lib "$Bin/";
use GFS_timezone;
use GFS_time;
use JSON;

$process_limit = 1;
@process_slots = (-1, -1, -1, -1);
$TIMEOUT_VALUE = 180;  # 2 minutes


sub wait_for_process_slot
{
    my $process_slot;

    while (1)
    {
        for $process_slot (0..$process_limit-1)
        {
            if ($process_slots[$process_slot] < 0)
            {
                return $process_slot;
            }
        }

        if (wait_for_children(1) < 1)
        {
            return -1;
        }
    }
}

$pid = fork;
print "\$pid = $pid\n";
my $slot = wait_for_process_slot();
print "\$slot = $slot\n";
$start_time[$slot] = time;
print "\$start_time[$slot] = $start_time[$slot]\n";
