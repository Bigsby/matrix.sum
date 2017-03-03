. "./results.ps1"

class CurrentHolder{
    [int]$Row
    [int]$Column
    [int]$StartRow
    [int]$StartColumn
    hidden [int]$side

    CurrentHolder([int]$row, [int]$column, [int]$side){
        $this.Row = $this.StartRow = $row
        $this.Column = $this.StartColumn = $column
        $this.side = $side
    }

    [int] ActualRow(){
        return $this.Actual($this.Row)
    }

    [int] ActualColumn(){
        return $this.Actual($this.Column)
    }

    [void] Next([int]$count){
        if ($count % $this.side -ne 0){
            $this.Row++
            $this.Column++
        }else{
            $this.Row = ++$this.StartRow
            $this.Column = --$this.StartColumn
        }
    }

    hidden [int] Actual([int]$value){
        if ($value -lt 0){
            return $value + $this.side
        }elseif ($value -ge $this.side){
            return $value - $this.side
        }
        return $value;
    }
}
class MatrixCalculator {
    hidden [int[,]] static CreateEmptyMatrix($side){
        return New-Object "int[,]" $side, $side
    }

    hidden [bool] static TestResult([int[,]]$matrix, [int]$expectedSum, [int]$side){
        
        for ($rowIndex = 0; $rowIndex -lt $side; $rowIndex++){
            $sum = 0;
            for ($columnIndex = 0; $columnIndex -lt $side; $columnIndex++){
                $sum += $matrix[$rowIndex, $columnIndex];
            }
            if ($sum -ne $expectedSum){
                return $false;
            }
        }

        for ($columnIndex = 0; $columnIndex -lt $side; $columnIndex++){
            $sum = 0;
            for ($rowIndex = 0; $rowIndex -lt $side; $rowIndex++){
                $sum += $matrix[$rowIndex, $columnIndex];
            }
            if ($sum -ne $expectedSum){
                return $false;
            }
        }

        $diagonalSum = 0;
        for ($diagonalIndex = 0; $diagonalIndex -lt $side; $diagonalIndex++){
            $diagonalSum += $matrix[$diagonalIndex, $diagonalIndex];
        }
        if ($diagonalSum -ne $expectedSum){
            return $false;
        }

        $diagonalSum = 0;
        for ($diagonalIndex = 0; $diagonalIndex -lt $side; $diagonalIndex++){
            $diagonalSum += $matrix[$diagonalIndex, ($side - $diagonalIndex - 1)];
        }
        if ($diagonalSum -ne $expectedSum){
            return $false;
        }

        return $true;
    }

    [MatrixResult] static Calculate([int]$side){
        if (($side % 2) -ne 1) {
            throw [System.Exception] "Side needs to be an odd number."
        }
        $expectedSum = $side * ($side * $side + 1) / 2
        $matrix = [MatrixCalculator]::CreateEmptyMatrix($side)
        $current = [CurrentHolder]::new(-($side - 1) / 2, ($side - 1)/2, $side)
        Write-Host "$($current.ActualRow()),$($current.ActualColumn())"
        foreach($count in 1..($side*$side)) {
            $matrix[$current.ActualRow(), $current.ActualColumn()] = $count
            
            $current.Next($count)
        }

        return [MatrixResult]::new($matrix,$expectedSum, $side, [MatrixCalculator]::TestResult($matrix, $expectedSum, $side));
    }
}