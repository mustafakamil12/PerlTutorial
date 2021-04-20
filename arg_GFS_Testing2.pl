#!/usr/bin/perl
print "before process @ARGV\n";

$arg = shift;

print "\$arg = $arg \n";
=POD
while ($arg = shift)
{
   $arg =~ s/^@// ;
   print "Before if statement: \$arg: $arg\n";

   if ($arg =~ s/^@//)
   {
     print "if the boolean exp. is True \$arg => $arg\n";
   }
   else{
     print "if the boolean exp. is False: $arg\n";
   }
}
=CUT
