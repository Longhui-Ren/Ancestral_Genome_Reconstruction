#!/usr/bin/perl
use warnings;

#Author: Longhui Ren (lhren@iastate.edu)

my $usage_string = <<EOS;
Usage: perl 06_redefine_block_details.pl synteny_file > output_file

	This script will redefine the syntenic blocks and determine the block details in combined and processed synteny file..

	Synteny_file is the combined and processed synteny file contianing multiple species..

	Output_file is the syteny file with redefined syntenic blocks.
EOS

die "\n$usage_string\n" unless (scalar(@ARGV) == 1);

$num_species=0;

open(I, "$ARGV[0]")or die("Can not open $ARGV[0]:$!");

<I>;
$line=<I>;
chomp$line;
@in=split(/\s+/,$line);
$num_columns=@in;
$num_species=$num_columns/5;

close(I)or die;

open(I, "$ARGV[0]")or die("Can not open $ARGV[0]:$!");

$line=<I>;
chomp$line;
$qchr="NA";
$num_gp=0;
$qstart=1000000000000;
$qend=0;

@tchr=();
@tstart=();
@tend=();
@tdirect=();
@tnum_gene=();

for($i=2;$i<=$num_species;$i++){
	$tchr[$i-2]="NA";
	$tstart[$i-2]=1000000000000;
	$tend[$i-2]=0;
	$tdirect[$i-2]="NA";
	$tnum_gene[$i-2]=0;
}

$gene_pairs="";

while(<I>){
	$line=$_;
	chomp$line;
	@in=split(/\s+/,$line);
	if($line!~/^#/){
		$num_gp=$num_gp+1;
		if($in[0] ne "NA"){
			$qchr=$in[0];
		}
		$gene_pairs=$gene_pairs.$line."\n";
		if($in[2] ne "NA" && $in[2]<$qstart){
			$qstart=$in[2];
		}
		if($in[3] ne "NA" && $in[3]>$qend){
			$qend=$in[3];
		}
		for($i=2;$i<=$num_species;$i++){
			if($in[($i-1)*5] ne "NA"){
				$tchr[$i-2]=$in[($i-1)*5];
				$tnum_gene[$i-2]=$tnum_gene[$i-2]+1;
			}
			if($in[($i-1)*5+4] ne "NA"){
				$tdirect[$i-2]=$in[($i-1)*5+4];
			}
			if($in[($i-1)*5+2] ne "NA" && $in[($i-1)*5+2]<$tstart[$i-2]){
				$tstart[$i-2]=$in[($i-1)*5+2];
			}
			if($in[($i-1)*5+3] ne "NA" && $in[($i-1)*5+3]>$tend[$i-2]){
				$tend[$i-2]=$in[($i-1)*5+3];
			}
		}
	}
	else{
		if($qstart==1000000000000){
			$qstart="NA";
		}
		if($qend==0){
			$qend="NA";
		}
		print "$qchr\tDAGchainer\t$qstart\t$qend\t$num_gp";
		for($i=2;$i<=$num_species;$i++){
			if($tstart[$i-2]==1000000000000){
				$tstart[$i-2]="NA";
			}
			if($tend[$i-2]==0){
				$tend[$i-2]="NA";
			}
			print "\t$tdirect[$i-2]\tmatches=$tchr[$i-2]:$tstart[$i-2]..$tend[$i-2]\t$tnum_gene[$i-2]";
		}
		print "\n$gene_pairs";
		$qchr="NA";
		$num_gp=0;
		$qstart=1000000000000;
		$qend=0;
		@tchr=();
		@tstart=();
		@tend=();
		@tdirect=();
		@tnum_gene=();
		for($i=2;$i<=$num_species;$i++){
			$tchr[$i-2]="NA";
			$tstart[$i-2]=1000000000000;
			$tend[$i-2]=0;
			$tdirect[$i-2]="NA";
			$tnum_gene[$i-2]=0
		}
		$gene_pairs="";
	}
}

# Doesn't need this section, since the file ends with a divider line.
# If the file ends with a gene pair line, this section needs to be activated.
#if($qstart==1000000000000){
#	$qstart="NA";
#}
#if($qend==0){
#	$qend="NA";
#}
#print "$qchr\tDAGchainer\t$qstart\t$qend\t$num_gp";
#for($i=2;$i<=$num_species;$i++){
#	if($tstart[$i-2]==1000000000000){
#		$tstart[$i-2]="NA";
#	}
#	if($tend[$i-2]==0){
#		$tend[$i-2]="NA";
#	}
#	print "\t$tdirect[$i-2]\tmatches=$tchr[$i-2]:$tstart[$i-2]..$tend[$i-2]";
#}
#print "\n$gene_pairs";

close(I)or die;
