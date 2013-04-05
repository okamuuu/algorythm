#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;
use Perl6::Slurp;

my $typical = slurp './data/typical.txt', {chomp => 1};

my %codemap_v1 = map { split ':', $_ } split "\n", slurp './data/codemap_v1.txt';
my %codemap_v2 = map { split ':', $_ } split "\n", slurp './data/codemap_v2.txt';

my $encoded1 = encode($typical, \%codemap_v1);
my $encoded2 = encode($typical, \%codemap_v2);

if ( $typical eq decode($encoded1, \%codemap_v1) ) {
    warn length $encoded1;
    print 'v1 is ok', "\n";
}

if ( $typical eq decode($encoded2, \%codemap_v2) ) {
    warn length $encoded2;
    print 'v2 is ok', "\n";
}

sub encode {
    my ($typical, $codemap) = @_;

    my @chars = split '', $typical;

    my $encoded = '';
    for my $char ( @chars ) {
        my $code = $codemap->{ $char };
        $encoded .= $code;
    }
    
    return $encoded; 
}

sub decode {
    my ($encoded, $codemap) = @_;

    my @encoded = split '', $encoded; 
    my %reversemap = map { $codemap->{$_} => $_ } keys %$codemap;

    my $code = '';
    my $decoded = '';
    
    while (1) {
   
        my $_code = shift @encoded;

        if ( !$_code ) {
            last;
        }

        $code .= $_code;

        if ($reversemap{$code}) {
            $decoded .= $reversemap{$code}; 
            $code = ''; 
        }
    }
    
    return $decoded; 
}


