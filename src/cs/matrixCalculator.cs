using System;
using System.Linq;
using Results;

public class MatrixCalculator
{
    private class CurrentHolder
    {
        private int _side;
        public CurrentHolder(int row, int column, int side)
        {
            Row = StartRow = row;
            Column = StartColumn = column;
            _side = side;
        }

        public int Row { get; set; }
        public int Column { get; set; }
        public int StartRow { get; set; }
        public int StartColumn { get; set; }

        private int Actual(int value){
            if (value < 0)
                return value + _side;
            if (value >= _side)
                return value - _side;
            
            return value;
        }

        public int ActualRow()
        {
            return Actual(Row);
        }

        public int ActualColumn()
        {
            return Actual(Column);
        }
    }

    private static bool TestResult(int[,] matrix, int expectedSum, int side)
    {
        for (var rowIndex = 0; rowIndex < side; rowIndex++) 
        {
            var sum = 0;
            for (var columnIndex = 0; columnIndex < side; columnIndex++)
                sum += matrix[rowIndex, columnIndex];
            
            if (sum != expectedSum)
                return false;
        }

        for (var columnIndex = 0; columnIndex < side; columnIndex++) 
        {
            var sum = 0;
            for (var rowIndex = 0; rowIndex < side; rowIndex++)
                sum += matrix[rowIndex, columnIndex];
            
            if (sum != expectedSum)
                return false;
        }

        var diagonalSum = 0;
        for (var diagonalIndex = 0; diagonalIndex < side; diagonalIndex++)
            diagonalSum += matrix[diagonalIndex, diagonalIndex];

        if (diagonalSum != expectedSum)
            return false;

        diagonalSum = 0;
        for (var diagonalIndex = 0; diagonalIndex < side; diagonalIndex++)
            diagonalSum += matrix[diagonalIndex, side - diagonalIndex - 1];

        return diagonalSum == expectedSum;
    }

    public static MatrixResult Calculate(int side)
    {
        if (side % 2 != 1)
            throw new Exception("Side needs to be an odd number.");

        var expectedSum = side * (side * side + 1) / 2;
        var matrix = CreateEmptyMatrix(side);
        var current = new CurrentHolder(-(side - 1) / 2, (int)Math.Floor((double)(side / 2)), side);

        for (var count = 1; count <= side * side; count++) {
            matrix[current.ActualRow(), current.ActualColumn()] = count;

            if (count % side != 0) {
                current.Row++;
                current.Column++;
            }
            else {
                current.Row = ++current.StartRow;
                current.Column = --current.StartColumn;
            }
        }

        return new MatrixResult(matrix, expectedSum, side, true);
    }

    private static int[,] CreateEmptyMatrix(int side)
    {
        return new int[side,side];
    }
}