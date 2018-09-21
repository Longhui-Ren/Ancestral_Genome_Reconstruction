#!/usr/bin/perl
use warnings;

#Author: Longhui Ren (lhren@iastate.edu)

my $usage_string = <<EOS;
Usage: perl 02_put_synteny_files_together.pl existing_synteny adding_synteny ref_column_number output_synteny

	This script will add one more synteny file to the existing synteny files.

	Existing_synteny can be the frist synteny in ready format or later version with multiple syntenies added to it.

	Adding_synteny is the synteny file you want to add with the format described in the workflow.

	Ref_column_number is the column number containing gene IDs in the reference genome you have chosen.

	Out_synteny is the output combined synteny file.

	##PAY ATTENTION TO THE FORMAT OF THE EXISTING AND ADDING SYNTENY FILE!##
EOS

die "\n$usage_string\n" unless (scalar(@ARGV) == 4);

$ref_ID=$ARGV[2]-1;

%hashID=();
%hashE=();
%hashN=();
$num_columns_E=0;

open(E, "$ARGV[0]")or die("Can not open $ARGV[0]:$!");
open(O,"+>temp.txt")or die("Can not open temp.txt:$!");

while(<E>){
	$line=$_;
	chomp$line;
	@in=split(/\s+/,$line);
	$num_columns_E=@in;
	$hashE{"$in[$ref_ID]"}=$line;
	print O "$in[$ref_ID-1]\t$in[$ref_ID]\t$in[$ref_ID+1]\n";
}

close(E)or die;

open(N, "$ARGV[1]")or die("Can not open $ARGV[1]:$!");

while(<N>){
	$line=$_;
	chomp$line;
	if($line=~/DAGchainer/){
		@in=split(/\s+/,$line);
		$direct=$in[5];
		$num=$in[4];
		$line=<N>;
		chomp$line;
		@in=split(/\s+/,$line);
		$gp_line="1\t".$in[0]."\t".$in[1]."\t".$in[2]."\t".$in[3]."\t"."+"."\t".$in[4]."\t".$in[5]."\t".$in[6]."\t".$in[7]."\t".$direct;
		$hashN{"$in[1]"}=$gp_line;
		print O "$in[0]\t$in[1]\t$in[2]\n";
		for($i=2;$i<=$num-1;$i++){
			$line=<N>;
			chomp$line;
			@in=split(/\s+/,$line);
			$gp_line="0\t".$in[0]."\t".$in[1]."\t".$in[2]."\t".$in[3]."\t"."+"."\t".$in[4]."\t".$in[5]."\t".$in[6]."\t".$in[7]."\t".$direct;
			$hashN{"$in[1]"}=$gp_line;
			print O "$in[0]\t$in[1]\t$in[2]\n";
		}
		$line=<N>;
		chomp$line;
		@in=split(/\s+/,$line);
		$gp_line="2\t".$in[0]."\t".$in[1]."\t".$in[2]."\t".$in[3]."\t"."+"."\t".$in[4]."\t".$in[5]."\t".$in[6]."\t".$in[7]."\t".$direct;
		$hashN{"$in[1]"}=$gp_line;
		print O "$in[0]\t$in[1]\t$in[2]\n";
	}
}

close(N)or die;
close(O)or die;

system('sort temp.txt | uniq | sort -k1,1 -k3,3n > temp_sort.txt');

open(T, "temp_sort.txt")or die("Can not open temp_sort.txt:$!");

$index=0;

while(<T>){
	$line=$_;
	chomp$line;
	@in=split(/\s+/,$line);
	$index=$index+1;
	$hashID{"$index"}=$in[1];
}

close(T)or die;

open(OS, "+>$ARGV[3]")or die("Can not open $ARGV[3]:$!");

foreach $key_ID (sort {$a<=>$b} keys %hashID){
	$gene_ID=$hashID{"$key_ID"};
	if(exists $hashE{"$gene_ID"} && not exists $hashN{"$gene_ID"}){
		$lineE=$hashE{"$gene_ID"};
		print OS "$lineE\tNA\tNA\tNA\tNA\tNA\n";
	}
	elsif(exists $hashE{"$gene_ID"} && exists $hashN{"$gene_ID"}){
		$lineE=$hashE{"$gene_ID"};
		$lineN=$hashN{"$gene_ID"};
		@inE=split(/\s+/,$lineE);
		@inN=split(/\s+/,$lineN);
		if($inE[0] eq "0" && $inN[0] eq "1"){
			$lineE=~s/^0/1/;
		}
		elsif($inE[0] eq "0" && $inN[0] eq "2"){
			$lineE=~s/^0/2/;
		}
		elsif($inE[0] eq "1" && $inN[0] eq "2"){
			$lineE=~s/^1/1,2/;
		}
		elsif($inE[0] eq "2" && $inN[0] eq "1"){
			$lineE=~s/^2/1,2/;
		}
		print OS "$lineE\t$inN[6]\t$inN[7]\t$inN[8]\t$inN[9]\t$inN[10]\n";
	}
	elsif(not exists $hashE{"$gene_ID"} && exists $hashN{"$gene_ID"}){
		$lineN=$hashN{"$gene_ID"};
		@inN=split(/\s+/,$lineN);
		if($ref_ID!=2){
			print OS "$inN[0]\t";
			for($i=1;$i<=$ref_ID-2;$i++){
				print OS "NA\t";
			}
			print OS "$inN[1]\t$inN[2]\t$inN[3]\t$inN[4]\t$inN[5]\t";
			for($i=$ref_ID+4;$i<=$num_columns_E-1;$i++){
				print OS "NA\t";
			}
			print OS "$inN[6]\t$inN[7]\t$inN[8]\t$inN[9]\t$inN[10]\n";
		}
		else{
			print OS "$inN[0]\t$inN[1]\t$inN[2]\t$inN[3]\t$inN[4]\t$inN[5]\t";
			for($i=6;$i<=$num_columns_E-1;$i++){
				print OS "NA\t";
			}
			print OS "$inN[6]\t$inN[7]\t$inN[8]\t$inN[9]\t$inN[10]\n";
		}
	}
}

close(OS)or die;
