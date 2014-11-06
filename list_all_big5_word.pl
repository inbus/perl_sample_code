#!/usr/bin/perl
#
use strict;
use warnings;
use feature qw/switch/;
no warnings qw/experimental::smartmatch/;
use subs qw(HELP);

HELP;

while(my $choice = <STDIN>){
    given ($choice) {
        when (/a/i) {
            list_word(0xa140,0xa3c0);
        }
        when (/b/i) {
            list_word(0xa3c0,0xa3e1);
        }
        when (/c/i) {
            list_word(0xa3e1,0xa440);
        }
        when (/d/i) {
            list_word(0xa440,0xc6a1);
        }
        when (/e/i) {
            list_word(0xc6a1,0xc940);
        }
        when (/f/i) {
            list_word(0xc940,0xf9d6);
        }
        when (/g/i) {
            list_word(0xf9d6,0xfa40);
        }
        when (/h/i) {
            list_word(0xfa40,0xfefe);
        }
        when (/i/i) {
            list_word(0x8e40,0xa140);
        }
        when (/j/i) {
            list_word(0x8140,0x8e40);
        }
        when (/k/i) {
            list_word(0x8140,0xfefe);
        }
        when (/x|q/i){
            exit;
        }
        default{
            HELP;
        }
    }
}

sub list_word {
    my ($lo_value,$hi_value) = @_;
    for ( 0x81 .. 0x8d , 0x8e .. 0xa0 , 0xa1 .. 0xfe ){
        my $hi_bit = sprintf '%2x',$_;
        for( 0x40 .. 0x7e , 0xa1 .. 0xfe ){
            my $lo_bit = sprintf '%2x',$_;
            if(hex("$hi_bit$lo_bit") >= $lo_value and hex("$hi_bit$lo_bit") < $hi_value){
                print "\n" if $lo_bit =~ /0$/;
                print "\n" if $lo_bit =~ /a1$/;
                print "符號區標準字\n" if "$hi_bit$lo_bit" =~ /a140/;
                print "符號區控制碼\n" if "$hi_bit$lo_bit" =~ /a3c0/;
                print "\n符號區控制碼保留範圍\n" if "$hi_bit$lo_bit" =~ /a3e1/;
                print "標準常用字\n" if "$hi_bit$lo_bit" =~ /a440/;
                print "罕用符號區\n" if "$hi_bit$lo_bit" =~ /c6a1/;
                print "標準次常用字\n" if "$hi_bit$lo_bit" =~ /c940/;
                print "\n標準次常用字保留範圍\n" if "$hi_bit$lo_bit" =~ /f9d6/;
                print "使用者造字第一段\n" if "$hi_bit$lo_bit" =~ /fa40/;
                print "使用者造字第三段\n" if "$hi_bit$lo_bit" =~ /8140/;
                print "使用者造字第二段\n" if "$hi_bit$lo_bit" =~ /8e40/;
                printf '%4s %2s ',$hi_bit.$lo_bit,pack('H4',$hi_bit.$lo_bit) ;
            }
        }
    }
    print "\n";
}
sub HELP{
    print "(a) 符號區標準字\n" ;
    print "(b) 符號區控制碼\n" ;
    print "(c) 符號區控制碼保留範圍\n" ;
    print "(d) 罕用符號區\n" ;
    print "(e) 標準常用字\n" ;
    print "(f) 標準次常用字\n" ;
    print "(g) 標準次常用字保留範圍\n" ;
    print "(h) 使用者造字第一段\n" ;
    print "(i) 使用者造字第二段\n" ;
    print "(j) 使用者造字第三段\n" ;
    print "(k) 所有字\n" ;
    print "(x|q) exit\n" ;
    print "choice you want to display ?\n";
}
