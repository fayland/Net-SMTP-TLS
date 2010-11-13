#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Net::SMTP::TLS::ButMaintained' );
}

diag( "Testing Net::SMTP::TLS::ButMaintained $Net::SMTP::TLS::ButMaintained::VERSION, Perl $], $^X" );
