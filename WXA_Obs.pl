#!/usr/bin/perl

use Date::Calc;

$pastDays = 1;

($year,$month,$day, $hour,$min,$sec) = Date::Calc::Today_and_Now();

($year, $month, $day) = Date::Calc::Add_Delta_Days($year, $month, $day, ($pastDays * -1));

print "\$year, \$month, \$day, \$hour, \$min, \$sec = $year,$month,$day, $hour,$min,$sec\n";

($year, $month, $day) = Date::Calc::Add_Delta_Days($year, $month, $day, ($pastDays * -1));

print "\$year, \$month, \$day = $year, $month, $day\n";

($year,$month,$day, $hour,$min,$sec) = Date::Calc::Today_and_Now();

print "\$year, \$month, \$day, \$hour, \$min, \$sec = $year, $month, $day, $hour, $min, $sec \n";
