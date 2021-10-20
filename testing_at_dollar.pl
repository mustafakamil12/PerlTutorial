splice @$struct_tm_ref,0,6,(0,0,0,1,0,36);
print"\@\$struct_tm_ref = @$struct_tm_ref \n";

$address = "Testing Address";
print "I will send this package to <Address>\n";

$PRODUCTID = "DTEHOURLYFCST";
$CLIENTID = "gfs" . substr($PRODUCTID,0,3);
print "$CLIENTID\n";

$randnumBase = (rand 3);
print "\$randnumBase = $randnumBase\n";
$randnum = $randnumBase - .001;
print "\$randnum = $randnum\n";
