<?php
class ParseSideResult{
    public $Success;
    public $Side;
    public $ErrorMessage;
    
    function __construct($value){
        if(gettype($value) == "integer"){
            $this->Success = true;
            $this->Side = $value;
        }else{
            $this->Success = false;
            $this->ErrorMessage = $value;
        }
    }
}

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