. "./consoleUtil.ps1"
. "./results.ps1"
. "./matrixCalculator.ps1"

function ErrorOut{
    param([string]$message)
    Write-Host $message
    exit
}

function  ParseSideInput ([string]$inputSide) {
    if ($inputSide -match "^[0-9]+$"){
        return [ParseSideResult]::new([convert]::ToInt32($inputSide, 10))
    }else{
        return [ParseSideResult]::new("Side input not valid!")
    }
}

function Main ([string[]]$cliargs) {
    $inputSide = ""
    if ($cliargs.Length){
        $inputSide = $cliargs[0]
    } else {
        $inputSide = [ConsoleUtil]::Prompt("Input side (odd)")
    }

    $parseResult = ParseSideInput($inputSide)

    if ($parseResult.Success) {
        try {
            $result = [MatrixCalculator]::Calculate($parseResult.Side)
            if ($result.Success) {
                Write-Host "Matrix calculated successfully!"
                [ConsoleUtil]::DisplayMatrixResult($result)
            } else {
                Write-Host "Error calculating matrix!!!"
            }    
        }
        catch {
            ErrorOut($_.Exception.Message)
        }
        
    }else{
        ErrorOut($parseResult.ErrorMessage)
    }
}

Main($args)

<# 
This is a 
To execute run in the Powershell:
> main.ps1
or provide the side:
> main.ps1 7
#>