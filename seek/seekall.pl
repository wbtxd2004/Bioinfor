#!/usr/bin/perl
use strict;
#use warnings;

my $inpath="/Users/ZhiAnJu/workspace/bioinfo/output/1/";   #dir to input, chane it when you use different equipment; 
my $outpath="/Users/ZhiAnJu/workspace/bioinfo/output/seekout/test/";#dir to output;
my $bsaxi1 = "[A-Z]{8}AC[A-Z]{5}CTCC[A-Z]{6}";
my $bsaxi2 = "[A-Z]{6}GGAG[A-Z]{5}GT[A-Z]{8}";
my $bsaxilen = 25;
#my $str="";
my %alltag = ();
my %num = ();
my $tagid = 0;     
my ($aaa,$bbb);
my @aa;
my @bb;
my @input=qw(DroMel DroSim DroSec DroYak DroEre DroAna DroPse DroPer DroWil DroMoj DroVir DroGri);
my $inlength=@input;
print "Number of file is $inlength \n";
my $i=0;
for ($i=0;$i<$inlength;$i++){
	#my %alltag = ();
	#my %num = ();
	#my $tagid = 0; 
	my $str="";
	my $indir="$inpath"."$input[$i]".".mfa";
	my $outdir="$outpath"."$input[$i]".".fa";
	open IN,"<$indir" or die "Can't open input file: $!";
	foreach (<IN>){
		unless (/>$input[$i]\w+/){
		chomp;
		$str .= $_;
		}
	}
	close IN;
	
	open OUT,">$outdir" or die "Can't open input file: $!";
	while($str =~ /$bsaxi1/g){
	my $pos = pos($str);
	my $startpoint = $pos - $bsaxilen;
	my $tag = substr($str,$startpoint,$bsaxilen);
	$startpoint++;
	if(length($tag) >= $bsaxilen){
		$tagid++;
		unless($tag =~ /N+/){
			print OUT ">"."$input[$i]"."_tag"."$tagid\n$tag\n";
			$alltag{$tagid} = $tag;
			$num{$tag}++;
			}
		}
	}
	@aa=keys %alltag;
	$aaa=@aa;
	print "loop $i: $tagid $aaa\n";
	while($str =~ /$bsaxi2/g){
	my $pos = pos($str);
	my $startpoint = $pos - $bsaxilen;
	my $tag = substr($str,$startpoint,$bsaxilen);
	my $seq = reverse $tag;
	$seq =~ tr/ACGTacgt/TGCAtgca/;
	$startpoint++;
	if(length($seq) >= $bsaxilen){
		$tagid++;
		unless($seq =~ /N+/){
			print OUT ">"."$input[$i]"."_revtag"."$tagid\n$seq\n";
			$alltag{$tagid} = $seq;
			$num{$seq}++;
			}
		}
	}
	@bb=keys %alltag;
	$bbb=@bb;
	print "loop $i: $tagid $bbb \n";
	close OUT;	
}