#!/usr/bin/perl -w

#Author: Longhui Ren (lhren@iastate.edu)

my $usage_string = <<EOS;
Usage: perl check_gene_pair_order.pl synteny_file > output_file

	This script will check the order of gene pairs in each syntenic block, and report/mark those gene pairs disrupting the simply ascending or descending order of each syntenic block.

	Synteny_file is the synteny file with the format descirbed in the workflow.

	Output_file is a file just having one extra column as the indicator of disrupting gene order.

	**THE SYNTENY FILE MUST NOT BE SEPARATED BY CHROMOSOMES!**
EOS

die "\n$usage_string\n" unless (scalar(@ARGV) == 1);

open(I, "$ARGV[0]")or die("Can not open $ARGV[0]:$!");

while(<I>){
	$line=$_;
	chomp$line;
	@in=split(/\s+/,$line);
	$num_gene=$in[4];
	$direct=$in[5];
	print "$line\n";
	$line_gene=<I>;
	chomp$line_gene;
	@in_gene=split(/\s+/,$line_gene);
	$pre_start=$in_gene[2];
	$pre_end=$in_gene[3];
	$pre_t_start=$in_gene[6];
	$pre_t_end=$in_gene[7];
	print "$line_gene\n";
	for($i=2;$i<=$num_gene;$i++){
		$line_gene=<I>;
		chomp$line_gene;
		@in_gene=split(/\s+/,$line_gene);
		$start=$in_gene[2];
		$end=$in_gene[3];
		$t_start=$in_gene[6];
		$t_end=$in_gene[7];
		if($direct eq "+"){
			if($start<=$pre_end || $t_start<=$pre_t_end){
				print "$line_gene\tERROR\n";
			}
			else{
				print "$line_gene\n";
			}
		}
		elsif($direct eq "-"){
			if($start<=$pre_end || $t_end>=$pre_t_start){
				print "$line_gene\tERROR\n";
			}
			else{
				print "$line_gene\n";
			}
		}
		$pre_start=$start;
		$pre_end=$end;
		$pre_t_start=$t_start;
		$pre_t_end=$t_end;
	}
}

close(I)or die;
