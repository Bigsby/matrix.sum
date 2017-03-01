<?php
class MatrixResult{
    public $Matrix;
    public $Sum;
    public $Side;
    public $Success;

    function __construct($matrix, $sum, $side, $success){
        $this->Matrix = $matrix;
        $this->Sum = $sum;
        $this->Side = $side;
        $this->Success = $success;
    }
}
?>