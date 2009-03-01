#! /usr/bin/env perl

use strict;

my $perlpath = shift;
my $bindir = shift;
my $mandir = shift;
my $sysconfdir = shift;
my $version = shift;

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
  } elsif(/^  \$VERSION = /) {
    print YOUT "  \$VERSION = \"" . $version . "\";\n";
  } else {
    print YOUT;
  }
}

close(YOUT);
close(YIN);

eval {
  require Pod::Man;
  my $pod = Pod::Man->new(section=>1);
  $pod->parse_from_file ('yasql', 'yasql.1');
};
if($@) {
  warn "Generating man page failed, install Pod::Man to fix this"
}

print "Configuration successful\n";

