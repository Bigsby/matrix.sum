public class MatrixResult
{
    public MatrixResult(int[,] matrix, int sum, int side)
    {
        Matrix = matrix;
        Sum = sum;
        Side = side;
    }

    public int[,] Matrix { get; }
    public int Sum { get; }
    public int Side { get; }
}