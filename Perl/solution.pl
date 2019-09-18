#!/usr/bin/perl

use strict;
use warnings;


my %word2num = (
    'two', 2,
    'three', 3,
    'four', 4,
    'five', 5,
    'six', 6,
    'seven', 7,
    'eight', 8,
    'nine', 9,
    'ten', 10,
);



my $inputFile = $ARGV[0];

open my $fh, '<', $inputFile or die "Can't open file $!";
my $fileContent = do { local $/; <$fh> };

$fileContent =~ s/[^A-Za-z0-9,\s]//g;
my $processedContent = lc $fileContent;
my @fileWords = split ' ', $processedContent;

my %wordCount;

for (my $i=0; $i < @fileWords; $i++) {
    my $word = $fileWords[$i];
    my $nextWord = $fileWords[($i+1 < @fileWords ? $i+1 : $i)];
    my $multiplier = exists($word2num{$nextWord}) ? $word2num{$nextWord} : 1;
    if (not exists($word2num{$word})) {
        $wordCount{$word} += $multiplier;
    }
}

my $limit = 5;
my $counter = 0;
foreach (sort { ($wordCount{$b} <=> $wordCount{$a}) || ($b cmp $a) } keys %wordCount)
{
    if ($counter < $limit) {
        print "$wordCount{$_} $_\n";
    }
    $counter += 1;
}