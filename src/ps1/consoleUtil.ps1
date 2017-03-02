class ConsoleUtil {
    [string] static Prompt ([string]$question){
        return Read-Host -Prompt $question
    }

    [void] static DisplayMatrixResult($result){
        $matrix = $result.Matrix
        $length = [System.Math]::Max(($result.Side * $result.Side).ToString().Length + 1, 2)

        for ($rowIndex = 0; $rowIndex -lt $result.Side; $rowIndex++){
            $rowText = ""
            for($columnIndex = 0; $columnIndex -lt $result.Side; $columnIndex++){
                $rowText += $matrix[$rowIndex,$columnIndex].ToString().PadLeft($length, " ")
            }
            Write-Host $rowText
        }
        
        Write-Host "Sum: $($result.Sum)"
    }
}