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

    private function Actual($value){
        if ($value < 0){
            return $value + $this->side;
        }
        if ($value >= $this->side) {
            return $value - $this->side;
        }
        return $value;
    }

    function ActualRow(){
        return $this->Actual($this->Row);
    }

    function ActualColumn(){
        return $this->Actual($this->Column);
    }
}

class MatrixCalculator{
    private static function CreateEmptyMatrix($side){
        return array_fill(0, $side, array_fill(0, $side, 0));
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

            if ($count % $side != 0){
                $current->Row++;
                $current->Column++;
            }else{
                $current->Row = ++$current->StartRow;
                $current->Column = --$current->StartColumn;
            }
        }

        return new MatrixResult($matrix, $expectedSum, $side, true);
    }
}
?>