<?php
include "console_util.php";
include "matrix_result.php";
include "matrix_calculator.php";

function ErrorOut($message){
    echo $message;
    exit();
}

$inputSide = "";

if ($argc == 1){
    $inputSide = ConsoleUtil::Prompt("Input side (odd):");
}else{
    $inputSide = $argv[1];
}

$side = 0;
if (is_numeric($inputSide)){
    $side = intval($inputSide);
}else{
    ErrorOut("Side number not valid!");
}

if ($side%2==0){
    ErrorOut("Side needs to be an odd number!");
}

$result = MatrixCalculator::Calculate($side);

echo $result->Success ? "Matrix calculated successfully!" : "Error calculating matrix!!!";
echo "\n";

ConsoleUtil::DisplayMatrixResult($result);

?>