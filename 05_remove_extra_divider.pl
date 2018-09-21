#!/usr/bin/perl
use warnings;

#Author: Longhui Ren (lhren@iastate.edu)

my $usage_string = <<EOS;
Usage: perl 05_remove_extra_divider.pl synteny_file > output_file

	This script will remove the extra divider lines in the combined and transformed synteny file without missing data.

	Synteny_file is the combined and transformed synteny file without missing data.
EOS

die "\n$usage_string\n" unless (scalar(@ARGV) == 1);

open(I, "$ARGV[0]")or die("Can not open $ARGV[0]:$!");

while(<I>){
	$line=$_;
	chomp$line;
	if($line!~/^#/){
		print "$line\n";
	}
	else{
		print "$line\n";
		while(<I>){
			$line_next=$_;
			chomp$line_next;
			if($line_next!~/^#/){
				print "$line_next\n";
				last;
			}
		}
	}
}

close(I)or die;
