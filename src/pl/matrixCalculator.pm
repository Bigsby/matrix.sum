package CurrentHolder;
use strict;
use warnings;
use results::matrixResult;

sub new{
    my $class = shift;
    my ($args) = @_;
    my $self = {
        row => $args->{row},
        column => $args->{column},
        startRow => $args->{row},
        startColumn => $args->{column},
        side => $args->{side}
    };

    return bless $self, $class;
}

sub _actual{
    my $self = shift;
    my $value = $_[0];
    if ($value < 0){
        return $value + $self->{side};
    }
    if ($value >= $self->{side}){
        return $value - $self->{side};
    }
    return $value;
}

sub actualRow{
    my $self = shift;
    return $self->_actual($self->{row});
}

sub actualColumn{
    my $self = shift;
    return $self->_actual($self->{column});
}

sub next{
    my $self = shift;
    my $count = $_[0];

    if (($count % $self->{side}) != 0) {
            $self->{row}++;
            $self->{column}++;
        }
        else {
            $self->{row} = ++$self->{startRow};
            $self->{column} = --$self->{startColumn};
        }
}

package MatrixCalculator;

sub _TestResult($){
    my ($args) = @_;
    my @matrix = @{$args->{matrix}};
    my $expectedSum = $args->{expectedSum};
    my $side = $args->{side};

    for my $rowIndex (0..($side - 1)){
        my $sum = 0;
        for my $columnIndex (0..($side - 1)){
            $sum += $matrix[$rowIndex][$columnIndex];
        }
        if ($sum != $expectedSum){
            return 0;
        }
    }

    for my $columnIndex (0..($side - 1)){
        my $sum = 0;
        for my $rowIndex (0..($side - 1)){
            $sum += $matrix[$rowIndex][$columnIndex];
        }
        if ($sum != $expectedSum){
            return 0;
        }
    }

    my $diagonalSum = 0;
    for my $diagonalIndex (0..($side - 1)){
        $diagonalSum += $matrix[$diagonalIndex][$diagonalIndex];
    }
    if ($diagonalSum != $expectedSum){
        return 0;
    }

    $diagonalSum = 0;
    for my $diagonalIndex (0..($side - 1)){
        $diagonalSum += $matrix[$diagonalIndex][$side - $diagonalIndex - 1];
    }
    return $diagonalSum == $expectedSum;
}

sub Calculate($){
    my $side = $_[0];

    if ($side % 2 != 1) {
        # new line needed to prevent error location in code from being displayed
        die "Side needs to be an odd number.\n"; 
    }

    my $expectedSum = $side * ($side * $side + 1) / 2;
    my @matrix;
    my $current = CurrentHolder->new({
        row => -($side - 1) / 2,
        column => ($side - 1) / 2,
        side => $side
    });

    for my $count (1..($side*$side)){
        $matrix[$current->actualRow()][$current->actualColumn()] = $count;
        my $value = $matrix[$current->actualRow()][$current->actualColumn()];

        $current->next($count);
    }

    return MatrixResult->new({
        matrix => \@matrix,
        sum => $expectedSum,
        side => $side,
        success => _TestResult({
            matrix => \@matrix,
            expectedSum => $expectedSum,
            side => $side
        })
    });
}

1;