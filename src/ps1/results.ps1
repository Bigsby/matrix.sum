class ParseSideResult{
    [bool]$Success
    [int]$Side
    [string]$ErrorMessage

    ParseSideResult([int]$side){
        $this.Side = $side;
        $this.Success = $true;
    }

    ParseSideResult([string]$errorMessage){
        $this.ErrorMessage = $errorMessage;
        $this.Success = $false;
    }
}

class MatrixResult {
    [int[,]] $Matrix
    [int] $Sum
    [int] $Side
    [bool] $Success
    MatrixResult([int[,]]$matrix, [int]$sum, [int]$side, [bool]$Success){
        $this.Matrix = $matrix
        $this.Sum = $sum
        $this.Side = $side
        $this.Success = $Success
    }
}