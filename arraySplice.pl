#! /usr/bin/perl

@nums = (1..20);
print "Before - @nums\n";

#splice @ARRAY, OFFSET [ , LENGTH [ , LIST ] ]
splice(@nums, 5, 5, 21..25);
print "After - @nums\n";