#!/usr/bin/perl

use strict;
use warnings;
use FindBin qw/$Bin/;
use Test::More;
use vars qw/%config/;

BEGIN {
    unless ( $ENV{TEST_TLS} ) {
        plan skip_all => 'set $ENV{TEST_TLS} to test';
    }
    open(my $fh, '<', "$Bin/config.txt") or do {
        plan skip_all => "Can't find $Bin/config.txt";
    };
    while (my $line = <$fh>) {
        chomp($line);
        my ($k, $v) = split(/\s*\=\s*/, $line);
        $config{$k} = $v;
    }
    close($fh);
    plan tests => 1;
}

use Net::SMTP::TLS::ButMaintained;

my $mailer = Net::SMTP::TLS::ButMaintained->new(
 	$config{host},
	Hello	=>	'fayland.org',
 	Port	=>	$config{port},
 	User	=>	$config{user},
 	Password=>	$config{pass}
);
$mailer->mail($config{user});
$mailer->to($config{to});
$mailer->data;
$mailer->datasend("Sent thru TLS!");
$mailer->dataend;
$mailer->quit;

1;