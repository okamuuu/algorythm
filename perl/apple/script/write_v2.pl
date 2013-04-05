#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;
use Perl6::Slurp;

my $typical = slurp './data/typical.txt', {chomp => 1};

my %map = ();
$map{$_}++ for split '', $typical;

my @words = map { +{$_ => $map{$_}} } reverse sort { $map{$a} <=> $map{$b} } keys %map;

my @ordered = reverse sort { $map{$a} <=> $map{$b} } keys %map;

my @codes = map { _parse($_); } map { chomp($_); $_ =~ s/\s//g; $_; } <DATA>;

my $text = join "\n", map { $_ . ':' . shift @codes } @ordered;

print $text;

sub _parse {
    my $numbers = shift;

    my $str = '';
    for my $num (split '', $numbers) {
       $str .= ['r', 'g', 'b']->[$num];
    }

    return $str;
}


__DATA__
    00   
    01   
    10
    11
   200 
   201 
   202 
   210 
   211 
   212 
  0200
  0201
  0202
  0210
  0211
  0212
  1200
  1201
  1202
  1210
  1211
  1212
  2200
  2201
  2202
  2210
  2211
  2212
