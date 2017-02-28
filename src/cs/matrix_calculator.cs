using System;
using System.Linq;

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

    public static MatrixResult Calculate(int side)
    {
        if (side % 2 != 1)
            throw new Exception("Side needs to be an odd number.");

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

        var sum = 0;
        for (var index = 0; index < side; index++)
            sum += matrix[0, index];

        return new MatrixResult(matrix, sum, side);
    }

    private static int[,] CreateEmptyMatrix(int side)
    {
        return new int[side,side];
    }
}