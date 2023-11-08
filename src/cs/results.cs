namespace Results
{
    public class ParseSideResult
    {
        private ParseSideResult(bool success)
        {
            Success = success;
            ErrorMessage = string.Empty;
        }

        public ParseSideResult(int side) : this(true)
        {
            Side = side;
        }

        public ParseSideResult(string errorMessage) : this(false)
        {
            ErrorMessage = errorMessage;
        }
        
        public bool Success { get; }
        public int Side { get; }
        public string ErrorMessage { get; }
    }

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
}
