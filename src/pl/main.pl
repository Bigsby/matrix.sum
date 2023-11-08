use strict;
use warnings;
use consoleUtil;
use results::parseSideResult;
use matrixCalculator;

sub _ParseSideInput {
    if ($_[0] =~ /^[0-9]+$/){
        return ParseSideResult->new({ side => $_[0] + 0 });
    }
    else{
        return ParseSideResult->new({ errorMessage => "Side input not valid!" });
    }
}

sub _ErrorOut{
    print $_[0];
    exit 0;
}

sub Main {
    my $inputSide = "";
    if (scalar(@ARGV)){
        $inputSide = $ARGV[0];
    }else{
        $inputSide = ConsoleUtil::Prompt("Input side (odd):");
    }

    my $parseResult = _ParseSideInput($inputSide);

    if ($parseResult->{success}){
        my $result = eval{
            MatrixCalculator::Calculate($parseResult->{side});
        };

        if ($@) {
            _ErrorOut($@);
        }

        #"Matrix calculated successfully!" : "Error calculating matrix!!!"

        if ($result->{success}){
            print "Matrix calculated successfully!\n";
            ConsoleUtil::DisplayMatrixResult($result);
        }else{
            print "Error calculating matrix!!!"
        }

    }else{
        _ErrorOut($parseResult->{errorMessage});
    }
}

Main();

