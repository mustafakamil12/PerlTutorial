#!/usr/bin/perl -w

@array        = ("a", "e", "i", "o", "u");
@removedItems = splice(@array, 0 , 3, ("A", "E", "I"));

print "Removed items: @removedItems\n";

@struct_tm_ref = (0,0,0,21,7,121,-1);

if ($struct_tm_ref->[5] < 70)
{
    splice @$struct_tm_ref,0,6,(0,0,0,1,0,70);
}
if ($struct_tm_ref->[5] > 137)
{
    splice @$struct_tm_ref,0,6,(59,59,23,31,11,137);
}
print "\@struct_tm_ref = @struct_tm_ref\n";
