#!/usr/bin/perl

# Display all the files in /tmp directory.
print "Display all the files in /tmp directory\n";
$dir = "/tmp/*";
my @files = glob( $dir );

foreach (@files ) {
   print $_ . "\n";
}

# Display all the C source files in /tmp directory.
print "Display all the C source files in /tmp directory\n";
$dir = "/tmp/*.c";
@files = glob( $dir );

foreach (@files ) {
   print $_ . "\n";
}

# Display all the hidden files.
print "Display all the hidden files\n";
$dir = "/tmp/.*";
@files = glob( $dir );
foreach (@files ) {
   print $_ . "\n";
}

# Display all the files from /tmp and /home directories.
print "Display all the files from /tmp and /home directories\n";
$dir = "/tmp/* /home/*";
@files = glob( $dir );

foreach (@files ) {
   print $_ . "\n";
}