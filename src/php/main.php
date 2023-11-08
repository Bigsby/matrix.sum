<?php
include "console_util.php";
include "results.php";
include "matrix_calculator.php";

function ParseSideInput($inputSide){
    if (preg_match("/^[0-9]+$/", $inputSide)){
        return new ParseSideResult(intval($inputSide));
    }else{
        return new ParseSideResult("Side input not valid!");
    }
}

function ErrorOut($message){
    echo $message;
    exit();
}

function Main($argc, $argv){
    $inputSide = "";

    if ($argc == 1){
        $inputSide = ConsoleUtil::Prompt("Input side (odd):");
    }else{
        $inputSide = $argv[1];
    }

    $parseResult = ParseSideInput($inputSide);

    if ($parseResult->Success){
        try{
            $result = MatrixCalculator::Calculate($parseResult->Side);

            echo $result->Success ? "Matrix calculated successfully!" : "Error calculating matrix!!!";
            echo "\n";

            ConsoleUtil::DisplayMatrixResult($result);
        } catch (Exception $ex){
            ErrorOut($ex->getMessage());
        }
    }else{
        ErrorOut($parseResult->ErrorMessage);
    }
}

Main($argc, $argv);

?>
