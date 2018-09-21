#!/usr/bin/perl
use warnings;

#Author: Longhui Ren (lhren@iastate.edu)

my $usage_string = <<EOS;
Usage: perl 04_remove_missing_data.pl synteny_file > output_file

	This script will remove lines with missing data in more than 2 copies, which means more than 10 NAs in one row in the synteny file. Outgroup species is not considered when counting missing data.

	Synteny_file is the combined and transformed synteny file.

	##OUTGROUP SPECIES HAS TO BE THE LAST SPECIES ADDED INTO THE COMBINED SYNTENY!##
EOS

die "\n$usage_string\n" unless (scalar(@ARGV) == 1);

open(I, "$ARGV[0]")or die("Can not open $ARGV[0]:$!");

while(<I>){
	$line=$_;
	chomp$line;
	if($line=~/^#/){
		print "$line\n";
	}
	else{
		@in=split(/\s+/,$line);
		$num=@in;
		$num_missing=0;
		for($i=1;$i<=$num-5;$i++){
			if($in[$i-1] eq "NA"){
				$num_missing=$num_missing+1;
			}
		}
		if($num_missing<=10){
			print "$line\n";
		}
	}
}

close(I)or die;
