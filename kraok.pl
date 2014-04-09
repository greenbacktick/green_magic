#!/usr/bin/perl

use strict;
use warnings;

use LWP::Simple;

my @letterslist = ('ab','cd','eg','hj','km','np','rz');
my @content;
my $url;

foreach my $letters (@letterslist) {
        $url = "http://www.espace-francophone.com/karaoke/index_$letters.html";
        my @tmp_content = split('\n',get $url);
        die "Couldn't get $url" unless @tmp_content;
        push @content,@tmp_content;
}

my ($filename_path, $zip_url);
my $count = 5;
foreach my $line (@content) {
        next if $line !~ /.*zip/;
        ($filename_path) = $line =~ /^.*<a href="(.*zip).*">/;
        $zip_url = "http://www.espace-francophone.com/karaoke/".$filename_path;
        my ($filename) = $zip_url =~ /^.*\/(.*zip)/;
        getstore($zip_url,$filename);
        sleep (2);
        $count --;
        exit 0 if $count < 1;
}
