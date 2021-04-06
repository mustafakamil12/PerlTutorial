package T;

require Exporter;
@ISA = qw/Exporter/;
@EXPORT = qw/function/;
use Carp;

print "@ISA\n";
print "@EXPORT\n";

for(@ISA){
	print("$_","\n");
}

sub function {
   warn "Error in module!";
}
1;
