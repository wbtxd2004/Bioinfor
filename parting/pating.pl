#!/usr/bin/perl
use strict;
use warnings;

my $inpath="/Users/ZhiAnJu/workspace/parting/";   #dir to input, chane it when you use different equipment; 
my $outpath="/Users/ZhiAnJu/workspace/parting//output/";#dir to output;

open OUT, ">"."$outpath"."step1.tsv" || die "$!";
open IN, "<"."$inpath"."allinone.tags.tsv" || die "$!";
undef $/;
my $content = <IN>;
$content .="consensus";
for ($content =~ /consensus.*?consensus/s){
my $str=$&;
#chop $str;
print OUT "$str";
}
close IN;
close OUT;