 $fname = "/Users/mustafaalogaidi/Desktop/MyWork/TutorialsPoint-Perl/Hello.txt";
 @fstat = stat($fname);
 print "\@fstat = @fstat\n";
 print "\$\#fstat = $#fstat \n";
if ($#fstat < 9)
{
    print "NO FILE\n";
}
 $age = time - $fstat[9];
