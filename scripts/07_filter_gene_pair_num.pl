#!/usr/bin/perl
use warnings;

#Author: Longhui Ren (lhren@iastate.edu)

my $usage_string = <<EOS;
Usage: perl 07_filter_gene_pair_num.pl synteny_file gene_pair_num > output_file

	This script will discard syntenic blocks with less than certain number of gene pairs.

	Synteny_file is the combined and redefined synteny file.

	Gene_pair_num is the minimium number of gene pairs in a syntenic block for that block to be kept.
EOS

die "\n$usage_string\n" unless (scalar(@ARGV) == 2);

open(I, "$ARGV[0]")or die("Can not open $ARGV[0]:$!");

while(<I>){
	$line=$_;
	chomp$line;
	if($line=~/DAGchainer/){
		@in=split(/\s+/,$line);
		$num_gp=$in[4];
		if($num_gp>=$ARGV[1]){
			print "$line\n";
			for($i=1;$i<=$num_gp;$i++){
				$line=<I>;
				chomp$line;
				print "$line\n";
			}
		}
		else{
			for($i=1;$i<=$num_gp;$i++){
				<I>;
			}
		}
	}
}

close(I)or die;
