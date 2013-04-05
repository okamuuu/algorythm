#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;
use Perl6::Slurp;

my $typical = slurp './data/typical.txt', {chomp => 1};

my %map = ();
$map{$_}++ for split '', $typical;

my @words = map { +{$_ => $map{$_}} } reverse sort { $map{$a} <=> $map{$b} } keys %map;
warn Dumper \@words;
