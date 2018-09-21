#!/usr/bin/perl
use warnings;

#Author: Longhui Ren (lhren@iastate.edu)

my $usage_string = <<EOS;
Usage: perl 01_get_first_synteny_ready.pl synteny_file > output_file

	This script will set up the first synteny in right format and get it ready for adding other synteny files.

	Synteny_file is the synteny file with the format described in the workflow.
EOS

die "\n$usage_string\n" unless (scalar(@ARGV) == 1);

open(I, "$ARGV[0]")or die("Can not open $ARGV[0]:$!");

while(<I>){
	$line=$_;
	chomp$line;
	if($line=~/DAGchainer/){
		@in=split(/\s+/,$line);
		$direct=$in[5];
		$num=$in[4];
		$line=<I>;
		chomp$line;
		@in=split(/\s+/,$line);
		print "1\t$in[0]\t$in[1]\t$in[2]\t$in[3]\t+\t$in[4]\t$in[5]\t$in[6]\t$in[7]\t$direct\n";
		for($i=2;$i<=$num-1;$i++){
			$line=<I>;
			chomp$line;
			@in=split(/\s+/,$line);
			print "0\t$in[0]\t$in[1]\t$in[2]\t$in[3]\t+\t$in[4]\t$in[5]\t$in[6]\t$in[7]\t$direct\n";
		}
		$line=<I>;
		chomp$line;
		@in=split(/\s+/,$line);
		print "2\t$in[0]\t$in[1]\t$in[2]\t$in[3]\t+\t$in[4]\t$in[5]\t$in[6]\t$in[7]\t$direct\n";
	}
}

close(I)or die;
