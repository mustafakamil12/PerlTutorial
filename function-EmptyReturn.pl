sub testingRoutines{
  $testing=1;
  return($testing)
}

$final=\&testingRoutines;
print "value return: ", &$final, "\n";
