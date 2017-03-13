package ConsoleUtil;

use strict;
use warnings;
use List::Util qw[max];

sub Prompt($){
    print "$_[0]";
    return <STDIN>;
}

sub DisplayMatrixResult($){
    my ($args) = @_;
    my @matrix = @{$args->{matrix}};
    my $sum = $args->{sum};
    my $side = $args->{side};

    my $length = max(length($side * $side) + 1, 2);

    for my $rowIndex (0..($side - 1)){
        for my $columnIndex (0..($side-1)){
            my $value = $matrix[$rowIndex][$columnIndex];
            print " " x ($length - length($value)) . $value;
        }
        print "\n";
    }
    
    print "Sum: $sum";
}

1;