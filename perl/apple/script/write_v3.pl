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
     0   
     1   
   200 
   201 
   202 
   210 
   211 
   212 
  2200
  2201
  2202
  2210
  2211
  2212
 22200
 22201
 22202
 22210
 22211
 22212
222200
222201
222202
222210
222211
222212
