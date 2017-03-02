. "./consoleUtil.ps1"
. "./parseSideResult.ps1"
. "./matrixResult.ps1"
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

$inputSide = ""
if ($args.Length){
    $inputSide = $args[0]
} else {
    $inputSide = [ConsoleUtil]::Prompt("Input side (odd)")
}

$parseResult = ParseSideInput()
$side = 0
try {
    $side = [convert]::ToInt32($inputSide, 10)
}
catch {
    ErrorOut -message "Side number not valid!"
}

if ($side % 2 -eq 0){
    ErrorOut -message "Side needs to be an odd number!"
}

$result = [MatrixCalculator]::Calculate($side)
if ($result.Success) {
    Write-Host "Matrix calculated successfully!"
    [ConsoleUtil]::DisplayMatrixResult($result)
} else {
    Write-Host "Error calculating matrix!!!"
}

<# 
This is a 
To execute run in the Powershell:
> main.ps1
or provide the side:
> main.ps1 7
#>