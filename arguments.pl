$test = join(" ", @ARGV);
print("$test\n");

$arg = "Testing line \n";

print "$arg\n";

chomp $arg;

print "$arg \n";

unshift @ARGV,split(/ /,$arg);

print "@ARGV\n";
