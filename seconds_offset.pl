sub add_seconds
{
    $offs = shift;
    $time_t = 1625543925;
    if($time_t == -1)
    {
        return 0;
    }

    $secs = 0;
    if (defined offs)
    {
        $secs = $offs;
        $time_t += $secs;
    }
    return $secs;
}

$res = add_seconds(10);
print("\$res = $res\n");
