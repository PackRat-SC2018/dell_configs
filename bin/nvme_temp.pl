#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use Getopt::Long;

binmode(STDOUT, ":utf8");

# default values
my $t_warn = $ENV{T_WARN} || 70;
my $t_crit = $ENV{T_CRIT} || 90;
my $chip = $ENV{SENSOR_CHIP} || "nvme-pci-0300";   # run sensors to pick your chipset
my $temperature = -9999;

sub help {
    print "Usage: temperature [-w <warning>] [-c <critical>] [--chip <chip>]\n";
    print "-w <percent>: warning threshold to become yellow\n";
    print "-c <percent>: critical threshold to become red\n";
    print "--chip <chip>: sensor chip\n";
    exit 0;
}

GetOptions("help|h" => \&help,
           "w=i"    => \$t_warn,
           "c=i"    => \$t_crit,
           "chip=s" => \$chip);

# Get chip temperature
open (SENSORS, "sensors -u $chip |") or die;
while (<SENSORS>) {
    if (/^\s+temp1_input:\s+[\+]*([\-]*\d+\.\d)/) {
        $temperature = $1;
        last;
    }
}
close(SENSORS);

$temperature eq -9999 and die 'Cannot find temperature';

# Print short_text, full_text
#print "$temperature°C\n" x2;
print "$temperature°C\n" ;

# Print color, if needed
if ($temperature >= $t_crit) {
    print "#FF0000\n";
    exit 33;
} elsif ($temperature >= $t_warn) {
    print "#FFFC00\n";
}

exit 0;
