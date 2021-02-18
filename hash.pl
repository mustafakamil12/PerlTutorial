#!/usr/bin/perl

# u can use any of the ways below to define hash :)
#%data = ('John Paul', 45, 'Lisa', 30, 'Kumar', 40);
%data = ('John Paul' => 45, 'Lisa' => 30, -Kumar => 40); # u can use hyphen - instead of '' 
                                                         #for keys like what u use with Kumar

print "\$data{'John Paul'} = $data{'John Paul'}\n";
print "\$data{'Lisa'} = $data{'Lisa'}\n";
print "\$data{'Kumar'} = $data{-Kumar}\n";

$data{'Mustafa'} = 42;
print "\$data{'Mustafa'} = $data{'Mustafa'}\n"