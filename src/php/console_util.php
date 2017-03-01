<?php
class ConsoleUtil{
    public static function Prompt($question){
        echo $question;
        $handle = fopen ("php://stdin","r");
        return trim(fgets($handle));
    }

    public static function DisplayMatrixResult($result){
        $matrix = $result->Matrix;
        $length = max(strlen((string)($result->Side*$result->Side)) + 1, 2);

        for ($rowIndex = 0; $rowIndex < $result->Side; $rowIndex++){
            for ($columnIndex = 0; $columnIndex < $result->Side; $columnIndex++){
                echo str_pad((string)$matrix[$rowIndex][$columnIndex], $length, " ", STR_PAD_LEFT);
            }
            echo "\n";
        }

        echo "SUM: $result->Sum";
    }
}
?>