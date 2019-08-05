#!/usr/bin/perl
my $efile = shift @ARGV;

my %excludeh = ();
while(<>) {
    chomp;
    my ($id,$n) = split(/\t/);
    $excludeh{$id}=1;
}
print "entity\tentity label\n";
open(F,$efile) || die $efile;
while(<F>) {
    chomp;
    my ($id,$n) = split(/\t/);
    $id =~ m@/obo/(\w+)_@;
    my $s = $1;
    next unless $s eq 'UBERON' || $s eq 'GO' || $s eq 'CL' || $s eq 'WBbt' || $s eq 'FBbt' || $s eq 'MPATH' || $s eq 'NBO';
    if ($excludeh{$id}) {
        print STDERR "EXCLUDING: $_\n";
        next;
    }
    $id =~ s@^http://purl.obolibrary.org/obo/@@;
    print "$id\t$n\n";
    
}
close(F);
