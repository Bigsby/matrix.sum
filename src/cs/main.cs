using static System.Console;
using Results;

class Program 
{
    private static ParseSideResult ParseSideInput(string inputSide)
    {
        return new ParseSideResult("not implemented");
    }

    private static void ErrorOut(string message)
    {
        WriteLine(message);
        System.Environment.Exit(0);        
    }

    private static void Ask() {
        WriteLine("Asking...");
    }

    public static int Main (string[] args){
        var inputSide = string.Empty;

        if (args.Length == 0)
            inputSide = ConsoleUtil.Prompt("Input side (odd):");
        else
            inputSide = args[0];

        int side;
        if (!int.TryParse(inputSide, out side))
            ErrorOut("Side number not valid!");
        
         if (side % 2 == 0)
            ErrorOut("Side needs to be an odd number!");

        var result = MatrixCalculator.Calculate(side);
        WriteLine(result.Success ? "Matrix calculated successfully!" : "Error calculating matrix!!!");
        ConsoleUtil.DisplayMatrixResult(result);

        return 0;
    }
}

/*
To compile run:
> csc main.cs consoleUtil.cs matrixCalculator.cs results.cs

To execute run in the CLI:
> main
or provie the side:
> main 5
*/