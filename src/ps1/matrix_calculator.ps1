. "./matrix_result.ps1"

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

    [MatrixResult] static Calculate([int]$side){
        $expectedSum = $side * ($side * $side + 1) / 2
        $matrix = [MatrixCalculator]::CreateEmptyMatrix($side)
        $current = [CurrentHolder]::new(-($side - 1) / 2, ($side - 1)/2, $side)

        foreach($count in 1..($side*$side)) {
            $matrix[$current.ActualRow(), $current.ActualColumn()] = $count

            if ($count % $side -ne 0){
                $current.Row++
                $current.Column++
            }else{
                $current.Row = ++$current.StartRow
                $current.Column = --$current.StartColumn
            }
        }

        return [MatrixResult]::new($matrix,$expectedSum, $side, $true)
    }
}