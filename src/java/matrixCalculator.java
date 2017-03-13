import results.matrixResult;

public class matrixCalculator{

    private static class CurrentHolder{
        private int row;
        private int column;
        private int startRow;
        private int startColumn;
        private final int side;

        public CurrentHolder(int row, int column, int side){
            this.row = this.startRow = row;
            this.column = this.startColumn = column;
            this.side = side;
        }

        private int Actual(int value){
            if (value < 0)
                return value + this.side;
            if (value >= this.side)
                return value - this.side;
            
            return value;
        }

        public int ActualRow(){
            return Actual(this.row);
        }

        public int ActualColumn(){
            return Actual(this.column);
        }

        public void Next(int count)
        {
            if (count % this.side != 0) {
                this.row++;
                this.column++;
            }
            else {
                this.row = ++this.startRow;
                this.column = --this.startColumn;
            }
        }
    }

    private static int[][] CreateEmptyMatrix(int side){
        return new int[side][side];
    }

    private static boolean TestResult(int[][] matrix, int expectedSum, int side){
        for (int rowIndex = 0; rowIndex < side; rowIndex++) 
        {
            int sum = 0;
            for (int columnIndex = 0; columnIndex < side; columnIndex++)
                sum += matrix[rowIndex][columnIndex];
            
            if (sum != expectedSum)
                return false;
        }

        for (int columnIndex = 0; columnIndex < side; columnIndex++) 
        {
            int sum = 0;
            for (int rowIndex = 0; rowIndex < side; rowIndex++)
                sum += matrix[rowIndex][columnIndex];
            
            if (sum != expectedSum)
                return false;
        }

        int diagonalSum = 0;
        for (int diagonalIndex = 0; diagonalIndex < side; diagonalIndex++)
            diagonalSum += matrix[diagonalIndex][diagonalIndex];

        if (diagonalSum != expectedSum)
            return false;

        diagonalSum = 0;
        for (int diagonalIndex = 0; diagonalIndex < side; diagonalIndex++)
            diagonalSum += matrix[diagonalIndex][side - diagonalIndex - 1];

        return diagonalSum == expectedSum;
    }

    public static matrixResult Calculate(int side) throws Exception {
        if (side % 2 != 1)
            throw new Exception("Side needs to be an odd number.");

        int expectedSum = side * (side * side + 1) / 2;
        int[][] matrix = CreateEmptyMatrix(side);
        CurrentHolder current = new CurrentHolder(-(side - 1) / 2, (side - 1)/ 2, side);

        for (int count = 1; count <= side*side;count++){
            matrix[current.ActualRow()][current.ActualColumn()] = count;

            current.Next(count);
        }

        return new matrixResult(matrix, expectedSum, side, TestResult(matrix, expectedSum, side));
    }
}