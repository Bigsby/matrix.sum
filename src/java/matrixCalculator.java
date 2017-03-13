import results.*;

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

    public static results.matrixResult Calculate(int side) throws Exception {
        if (side % 2 != 1)
            throw new Exception("Side needs to be an odd number.");

        int expectedSum = side * (side * side + 1) / 2;
        int[][] matrix = CreateEmptyMatrix(side);
        CurrentHolder current = new CurrentHolder(-(side - 1) / 2, (side - 1)/ 2, side);

        for (int count = 1; count <= side*side;count++){
            matrix[current.ActualRow()][current.ActualColumn()] = count;

            current.Next(count);
        }

        return new results.matrixResult(matrix, expectedSum, side, true);
    }
}