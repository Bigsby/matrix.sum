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