sub report_error1
{
    print STDERR $_[0] . "\n";

}

sub report_error2
{
    print(@_ . "\n");
    print(@_[0]."\n");    #array Slice
    print($_[0]."\n");

}


report_error1("First Testing");

report_error2("First Testing","Second Testing");
