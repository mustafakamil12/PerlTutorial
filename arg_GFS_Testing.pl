#!/usr/bin/perl
print "before process @ARGV\n";

while ($arg = shift)
{
   print "\$arg: $arg\n";
   $arg =~ s/^@// ;
   print "\$arg => $arg\n";
   if ($arg =~ s/^@//)
   {
        print "first if\n";
        open ARG_FILE,$arg;
        $arg = <ARG_FILE>;
        chomp $arg;
        unshift @ARGV,split(/ /,$arg);
   }
   elsif ($arg eq "-cycle")
   {
       
       $build_cycle = 1;
       $cycle = shift;
   }
   elsif ($arg eq "-customer")
   {
       $build_customer = 1;
       $customer_code = shift;
   }
   elsif ($arg eq "-products" || $arg eq "-product")
   {
      print "we are in product testing\n";
      $build_products = 1;
      @prod_list = split(/,/, shift);
      print "\prod_list: @prod_list\n";
   }
   elsif ($arg eq "-time")
   {
     print "get time from anothe library\n";
      #$global_format_time = new GFS_time(shift);
   }
   elsif ($arg eq "-spawn")
   {
       $spawned = 1;
   }
   elsif ($arg eq "-gfs")
   {
       # take rest of arguments and pass them in to formatter
       $extra_args = join(' ',@ARGV);
       break;
   }
   # other potential parameters
    # override station list
    # override formatter
    # override output directory
    # override output filename
}
