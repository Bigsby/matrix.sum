use consoleUtil;

sub ErrorOut{
    print $_[0];
    exit 0;
}
$inputSide = "";
if (scalar(@ARGV)){
    $inputSide = @ARGV[0];
}else{
    $inputSide = ConsoleUtil::Prompt("Input side (odd):");
}

$side = 0;
if ($inputSide =~ /^[0-9]+$/){
    $side += $inputSide;
}else{
    ErrorOut("Side number not valid!");
}

print $side, "\n";

use matrixResult;

$result = MatrixResult->new(firstname => "B", lastname => "BBB");
print $result->name, "\n";
print $result->{firstname}, "\n";
$result->{lastname} = "other";
$result->{firstname} = "me";
print $result->name, "\n";