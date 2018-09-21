#!/usr/bin/perl
use warnings;

#Author: Longhui Ren (lhren@iastate.edu)

my $usage_string = <<EOS;
Usage: perl 03_transform_to_divider.pl synteny_file > output_file

	This script will transform the information recorded in the first column into divider lines in combined synteny file.

	Synteny_file is the combined synteny file with the first column recording the start and end information for syntenic blocks.
EOS

die "\n$usage_string\n" unless (scalar(@ARGV) == 1);

open(I, "$ARGV[0]")or die("Can not open $ARGV[0]:$!");

$divider="##########";

while(<I>){
	$line=$_;
	chomp$line;
	@in=split(/\s+/,$line);
	$num=@in;
	if($in[0] eq "1"){
		print "$divider\n";
#		print "$line\n";	# This line is for debug and test.
		for($i=1;$i<=$num-2;$i++){
			print "$in[$i]\t";
		}
		print "$in[$num-1]\n";
	}
	elsif($in[0] eq "2"){
#		print "$line\n";	# This line is for debug and test.
		for($i=1;$i<=$num-2;$i++){
			print "$in[$i]\t";
		}
		print "$in[$num-1]\n";
		print "$divider\n";
	}
	elsif($in[0] eq "1,2"){
		print "$divider\n";
#		print "$line\n";	# This line is for debug and test.
		for($i=1;$i<=$num-2;$i++){
			print "$in[$i]\t";
		}
		print "$in[$num-1]\n";
		print "$divider\n";
	}
	else{
#		print "$line\n";	# This line is for debug and test.
		for($i=1;$i<=$num-2;$i++){
			print "$in[$i]\t";
		}
		print "$in[$num-1]\n";
	}
}

close(I)or die;
