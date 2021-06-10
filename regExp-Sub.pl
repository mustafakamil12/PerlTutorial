#!/usr/bin/perl

use Time::Local;
use POSIX qw/strftime/;


$string = "The cat sat on the mat and spend \$30 Dollars";
$string =~ s/cat/dog/;

print "1. $string\n";

$string =~ s/\$/\\\$/g;
print "2. $string\n";

$string =~ s/ (\S*[\$#]\S*) / '"'"'"$1"'"'"' /g;

print "3. $string\n";

$week3 = "The cat sat on the mat and spend 30 Dollars\n";
$week3 =~ s/\s//g;
print "4. \$week3 = $week3\n";

$date_num = `date +%j`;
print "5. \$date_num = $date_num\n";


open (NGRIDOUT,">/Users/mustafaalogaidi/Desktop/MyWork/TutorialsPoint-Perl/NGRIDLR1");
$date_num = `date +%j`;

print NGRIDOUT "\n\n\n";
print NGRIDOUT "                       5 DAY NORMALS\n";
print NGRIDOUT "                       -------------\n\n";
print NGRIDOUT "Days:     Day 1      Day 2      Day 3      Day 4      Day 5\n";
print NGRIDOUT "ALB     ";

for ($i = $date_num; $i < $date_num + 5; $i++)
{
    $jday = ($i - 1) % 365;
    print NGRIDOUT "$alb_climo[$jday][2]/$alb_climo[$jday][0]/$alb_climo[$jday][1]   ";
}

print NGRIDOUT "\n";

$week_num = int($day_num) + 1;

print "\$day_num = $day_num \n";
print "\$week_num = $week_num\n";

open(WEEK4,"/Users/mustafaalogaidi/Desktop/MyWork/TutorialsPoint-Perl/Week4_AveT.txt");
$count = 1;
while (<WEEK4>)
{
    if ($count == 2)
    {
#        chop $_;
	$week4 = $_;
	last;
    }
    $count++;
}

print"\$week4 = $week4 \n";
