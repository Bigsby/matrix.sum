<?php

class CurrentHolder{
    public $Row;
    public $Column;
    public $StartRow;
    public $StartColumn;
    private $side;

    function __construct($row, $column, $side){
        $this->Row = $this->StartRow = $row;
        $this->Column = $this->StartColumn = $column;
        $this->side = $side;
    }

    function ActualRow(){
        return $this->Actual($this->Row);
    }

    function ActualColumn(){
        return $this->Actual($this->Column);
    }

    function Next($count){
        if ($count % $this->side != 0){
            $this->Row++;
            $this->Column++;
        }else{
            $this->Row = ++$this->StartRow;
            $this->Column = --$this->StartColumn;
        }
    }

    private function Actual($value){
        if ($value < 0){
            return $value + $this->side;
        }
        if ($value >= $this->side) {
            return $value - $this->side;
        }
        return $value;
    }
}

class MatrixCalculator{
    private static function CreateEmptyMatrix($side){
        return array_fill(0, $side, array_fill(0, $side, 0));
    }

    private static function TestResult($matrix, $expectedSum, $side){

        for ($rowIndex = 0; $rowIndex < $side; $rowIndex++){
            $sum = 0;
            for ($columnIndex = 0;$columnIndex < $side; $columnIndex++){
                $sum += $matrix[$rowIndex][$columnIndex];
            }
            if ($sum != $expectedSum)
                return false;
        }

        for ($columnIndex = 0; $columnIndex < $side; $columnIndex++){
            $sum = 0;
            for ($rowIndex = 0;$rowIndex < $side; $rowIndex++){
                $sum += $matrix[$rowIndex][$columnIndex];
            }
            if ($sum != $expectedSum)
                return false;
        }

        $diagonalSum = 0;
        for ($diagonalIndex; $diagonalIndex < $side; $diagonalIndex++){
            $diagonalSum += $matrix[$diagonalIndex][$diagonalIndex];
        }
        if ($diagonalSum != $expectedSum)
            return false;

        $diagonalSum = 0;
        for ($diagonalIndex; $diagonalIndex < $side; $diagonalIndex++){
            $diagonalSum += $matrix[$diagonalIndex][$side - $diagonalIndex -1];
        }
        if ($diagonalSum != $expectedSum)
            return false;

        return true;
    }

    public static function Calculate($side){
        if ($side % 2 != 1){
            throw new Exception("Side needs to be an odd number.");
        }

        $expectedSum = $side * ($side * $side + 1) / 2;
        $matrix = MatrixCalculator::CreateEmptyMatrix($side);
        $current = new CurrentHolder(-($side - 1) / 2, ($side -1) / 2, $side);

        for ($count = 1; $count <= $side*$side; $count++) {
            $matrix[$current->ActualRow()][$current->ActualColumn()] = $count;

            $current->Next($count);
        }

        return new MatrixResult($matrix, $expectedSum, $side, MatrixCalculator::TestResult($matrix, $expectedSum, $side));
    }
}
?>