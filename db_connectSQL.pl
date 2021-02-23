#!/usr/bin/perl

use DBI;
use strict;

my $driver = "mysql"; 
my $database = "TESTDB";
my $dsn = "DBI:$driver:database=$database";
my $userid = "testuser";
my $password = 'P@ssw0rd';

my $dbh = DBI->connect($dsn, $userid, $password ) or die $DBI::errstr;