package results;

public class matrixResult{
    private final boolean success;
    private final int[][] matrix;
    private final int sum;
    private final int side;

    public matrixResult(int[][] matrix, int sum, int side, boolean success){
        this.matrix = matrix;
        this.sum = sum;
        this.side = side;
        this.success = success;
    }

    public boolean getSuccess(){
        return this.success;
    }

    public int[][] getMatrix(){
        return this.matrix;
    }

    public int getSum(){
        return this.sum;
    }
    
    public int getSide(){
        return this.side;
    }
}
