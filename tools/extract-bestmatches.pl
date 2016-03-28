#!/usr/bin/perl
while(<>) {
    if (m@^\*(.*)@) {
        my @vals = split(/\t/,$1);
        print join("\t",@vals)."\n" if $vals[4] > 0.4;
    }
}
