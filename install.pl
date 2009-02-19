#! /usr/bin/env perl

use strict;

my $installpath = shift;
my $bindir = shift;
my $mandir = shift;
my $sysconfdir = shift;

print "Installing yasql to $bindir/yasql\n";
system("$installpath -m 755 yasql $bindir/yasql");

unless(-e "$sysconfdir/yasql.conf") {
  print "Installing yasql.conf to $sysconfdir/yasql.conf\n";
  system("$installpath -m 644 yasql.conf $sysconfdir/yasql.conf");
} else {
  print "$sysconfdir/yasql.conf exists, skipping config file installation.\n";
  print "Please read the documentation for info on any new ".
        "configuration directives\n";
}

if( -f "yasql.1" ) {
  print "Installing yasql.1 man page to $mandir/man1/yasql.1\n";
  system("mkdir -p $mandir/man1");
  system("$installpath -m 644 yasql.1 $mandir/man1/yasql.1");
} else {
  warn "yasql.1 not found, use perldoc $bindir/yasql to read the docs"
}

print "Installation successfull\n";

