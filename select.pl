#!/usr/bin/perl -w

open(FILE,">/tmp/t.out");
$oldHandle = select(FILE);
print("This is sent to /tmp/t.out.\n");
select($oldHandle);
print("This is sent to STDOUT.\n");
