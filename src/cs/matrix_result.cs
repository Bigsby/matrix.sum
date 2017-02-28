public class MatrixResult
{
    public MatrixResult(int[,] matrix, int sum, int side, bool success)
    {
        Matrix = matrix;
        Sum = sum;
        Side = side;
        Success = success;
    }

    public int[,] Matrix { get; }
    public int Sum { get; }
    public int Side { get; }
    public bool Success { get; }
}