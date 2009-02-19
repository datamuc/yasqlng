#! /usr/bin/env perl

use strict;

my $perlpath = shift;
my $bindir = shift;
my $mandir = shift;
my $sysconfdir = shift;

# read in yasql
open(YIN, "yasql.in") or die("Could not open yasql.in! $!");
# open yasql for writing
open(YOUT, ">yasql") or die("Could not open yasql for writing! $!");
flock(YOUT, 2) or die("Could not flock yasql! $!");

for(my $i = 0; <YIN>; $i++) {
  if($i == 0) {
    print YOUT "#!" . $perlpath . "\n";
  } elsif(/^\$sysconfdir = /) {
    print YOUT "\$sysconfdir = \"" . $sysconfdir . "\";\n";
  } else {
    print YOUT;
  }
}

close(YOUT);
close(YIN);

print "Configuration successful\n";

