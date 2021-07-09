use warnings;
use Data::Dumper qw(Dumper);

print Dumper \@ARGV;

while ($arg = shift)
{
   print("what \$arg in while loop = $arg \n");
   if ($arg =~ s/^@//)
   {
        open ARG_FILE,$arg;
        $arg = <ARG_FILE>;
        chomp $arg;
        unshift @ARGV,split(/ /,$arg);
   }
   elsif ($arg eq "-cycle")
   {
       $build_cycle = 1;
       $cycle = shift;
       print "\$cycle = $cycle\n";
   }
   elsif ($arg eq "-customer")
   {
       $build_customer = 1;
       $customer_code = shift;
       print "\n$customer_code = $customer_code\n";
   }
   elsif ($arg eq "-products" ||
          $arg eq "-product")
   {
      $build_products = 1;
      @prod_list = split(/,/, shift);
      print "\@prod_list = @prod_list\n";
   }
   elsif ($arg eq "-time")
   {
      print "\$arg  = $arg\n";
   }
   elsif ($arg eq "-spawn")
   {
       $spawned = 1;
       print "\ $spawned =  $spawned\n";
   }
   elsif ($arg eq "-gfs")
   {
       # take rest of arguments and pass them in to formatter
       $extra_args = join(' ',@ARGV);
       print "\$extra_args = $extra_args\n";
       break;
   }
   # other potential parameters
    # override station list
    # override formatter
    # override output directory
    # override output filename
}
