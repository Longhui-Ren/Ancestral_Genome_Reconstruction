#!/usr/bin/perl
use warnings;

#Author: Longhui Ren (lhren@iastate.edu)

my $usage_string = <<EOS;
Usage: perl redefine_block_details.pl synteny_file > output_file

	This script will redefine the block details like start, end, and number of gene pairs after removing some gene pairs in the block.

	Synteny_file is the synteny file with the format described in the workflow.

	Output_file is the redefined syteny file.

	**THE SYNTENY FILE MUST HAVE GENE PAIR INFORMATION AND NOT SEPARATED BY CHROMOSOMES!**
EOS

die "\n$usage_string\n" unless (scalar(@ARGV) == 1);

open(I, "$ARGV[0]")or die("Can not open $ARGV[0]:$!");

$line=<I>;
chomp$line;
@in=split(/\s+/,$line);
$direct=$in[5];
$in[6]=~/.*(median_Ks=.*)/;
$Ks=$1;
$qchr="";
$tchr="";
$num=0;
$qstart=1000000000000;
$qend=0;
$tstart=1000000000000;
$tend=0;
$gene_pairs="";

while(<I>){
	$line=$_;
	chomp$line;
	@in=split(/\s+/,$line);
	if($line!~/DAGchainer/){
		$num=$num+1;
		$qchr=$in[0];
		$tchr=$in[4];
		$gene_pairs=$gene_pairs.$line."\n";
		if($in[2]<$qstart){
			$qstart=$in[2];
		}
		if($in[3]>$qend){
			$qend=$in[3];
		}
		if($in[6]<$tstart){
			$tstart=$in[6];
		}
		if($in[7]>$tend){
			$tend=$in[7];
		}
	}
	else{
		print "$qchr\tDAGchainer\t$qstart\t$qend\t$num\t$direct\tmatches=$tchr:$tstart..$tend;$Ks\n$gene_pairs";
		$direct=$in[5];
		$in[6]=~/.*(median_Ks=.*)/;
		$Ks=$1;
		$qchr="";
		$tchr="";
		$num=0;
		$qstart=1000000000000;
		$qend=0;
		$tstart=1000000000000;
		$tend=0;
		$gene_pairs="";
	}
}

print "$qchr\tDAGchainer\t$qstart\t$qend\t$num\t$direct\tmatches=$tchr:$tstart..$tend;$Ks\n$gene_pairs";

close(I)or die;
