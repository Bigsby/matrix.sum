using static System.Console;

class Program {

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
To compile rum:
> csc main.cs console_util.cs matrix_calculator.cs matrix_result.cs

To execute run in ths CLI:
> main
or provie the side:
> main 5
*/