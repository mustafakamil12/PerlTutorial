#!/usr/bin/perl
#     $Revision: /main/2 $     $Modtime: 01/02/20 16:35:46 $    $Author: marshall $
#
#   Perl module:
#
#      GFS_DBI
#
#   Description:
#
#      Wrapper to the Perl standard DataBase Interface that allows for
#      driver-specific defaults for database connection.
#
#   Copyright (C) 2000, WSI Corporation
#
#   These coded instructions, statements, and computer programs contain
#   unpublished proprietary information of WSI Corporation, and are
#   protected by Federal copyright law.  They may not be disclosed
#   to third parties or copied or duplicated in any form, in whole or
#   in part, without the prior written consent of WSI Corporation.
#
#------------------------------------------------------------------------------

package GFS_DBI;

use strict;
use Env;
use DBI;

#
#  Default member values assuming the database is PostgreSQL
#
$GFS_DBI::designated_driver = $ENV{'GFS_DB_DRIVER'};
$GFS_DBI::default_driver    = "Pg";
%GFS_DBI::default_database  = ("Pg" => $ENV{'PGDATABASE'});
%GFS_DBI::default_hostname  = ("Pg" => $ENV{'PGHOST'});
%GFS_DBI::default_user      = ("Pg" => $ENV{'PGUSER'});
%GFS_DBI::default_password  = ("Pg" => "");

#
#  Class Method - connect
#  Description  - Connects to a database using the DBI w/ appropriate defaults.
#  Arguments    - All are optional
#                 $1 = user
#                 $2 = password
#                 $3 = database name
#                 $4 = hostname where database resides
#                 $5 = driver name
#  Returns      - Reference to DBConnection object or undefined on failure.
#  Uses         - In place of DBI->connect().
#
sub connect
{
    my $class = shift;

    #
    #  Set local variables with default values.
    #
    my $driver;
    if ($GFS_DBI::designated_driver ne "")
    {
        $driver = $GFS_DBI::designated_driver;
    }
    else
    {
        $driver = $GFS_DBI::default_driver;
    }

    my $database = $GFS_DBI::default_database{$driver};
    my $hostname = $GFS_DBI::default_hostname{$driver};
    my $user     = $GFS_DBI::default_user{$driver};
    my $password = $GFS_DBI::default_password{$driver};

    #
    #  Override defaults with constructor parameters.
    #
    if (defined $_[0])
    {
        $user = shift;
    }
    if (defined $_[0])
    {
        $password = shift;
    }
    if (defined $_[0])
    {
        $database = shift;
    }
    if (defined $_[0])
    {
        $hostname = shift;
    }
    if (defined $_[0])
    {
        $driver = shift;
    }

    #
    #  Format the connection string.
    #
    my $dsn = "DBI:$driver:dbname=$database";
    if (length($hostname) > 0)
    {
        $dsn .= ";host=$hostname";
    }

    #
    #  Set the optional attributes for the connection.
    #
    my %attr = ("RaiseError" => 0);
    $attr{'AutoCommit'} = 1;
    $attr{'PrintError'} = 0;
    $attr{'Warn'} = 0;

    #
    #  Connect to the database via the Perl DBI.
    #
    my $dbh = DBI->connect($dsn, $user, $password, \%attr);
    if (defined($dbh))
    {
        #
        #  Do any driver-specific setup prior to returning the DB handle.
        #
        if ($driver eq "Pg")
        {
            #
            #  Make sure we interpret date-times as UTC times, not local times.
            #
            $dbh->do("SET TIMEZONE = 'UTC'");
        }
    }

    return $dbh;
}

1; # Ensure that use/require get a return value of 1 when loading this module.