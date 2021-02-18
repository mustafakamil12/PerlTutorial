#!/usr/bin/perl

%data = ('John Paul' => 45, 'Lisa' => 30, 'Kumar' => 40);

if(exists($data{'Lisa'})){
    print "Lisa is $data{'Lisa'} years old\n";
} else {
    print "I don't know age of This person\n"
}