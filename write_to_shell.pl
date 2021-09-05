$cur_prod = 0;
$num_spreads = 3;
@prod_name = (0, 'BOFADLYFCSTN', 1, 'SARACENOBS', 2, 'NGRID_LI', 3, 'USEFCST', 4, 'DTEHOURLYFCST');

for ($x = 0; $x < $num_spreads; $x++)
{
    print "\$x = $x \n";
    open(BACKLOG,"ps -ef | grep spawn | grep -v grep | wc -l |");
    $data = <BACKLOG>;
    close BACKLOG;
    $data =~ s/\s//g;
#        $data -= 1;
    print "\$data = $data\n";
    while ($data >= 6)
    {
#            print "Backlog too high, waiting...\n";
        system("sleep 2");
        open(BACKLOG,"ps -ef | grep spawn | grep -v grep | wc -l |");
        $data = <BACKLOG>;
        close BACKLOG;
        $data =~ s/\s//g;
        #print "Backlog = $data \n";
        $data += 1;
    }

    for ($y = 0; $y < 2 && $cur_prod < $prod_count; $y++)
{
  system("/pgs/perlscripts/prod_build.pl -product $prod_name[$cur_prod] -spawn &");
  $cur_prod++;
}
system("sleep 1");
}
