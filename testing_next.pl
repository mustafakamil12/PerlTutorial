$looplimit = 1;
for $i (0 .. $looplimit - 1){
  print "\$i = $i\n";
  if ($i == 2)
  {
    print "we found that \$i == $i\n";
    next
  }
  print "we are at the end of for block\n";
}
