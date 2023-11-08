using System;
using System.Text.RegularExpressions;
using static System.Console;
using Results;

class Program 
{
    private static ParseSideResult ParseSideInput(string inputSide)
    {
        if (new Regex("^[0-9]+$").IsMatch(inputSide))
            return new ParseSideResult(int.Parse(inputSide));

        return new ParseSideResult("Side input not valid!");
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

        var parseResult = ParseSideInput(inputSide ?? "");

        if (parseResult.Success)
        {
            try 
            {
                var result = MatrixCalculator.Calculate(parseResult.Side);
                WriteLine(result.Success ? "Matrix calculated successfully!" : "Error calculating matrix!!!");
                ConsoleUtil.DisplayMatrixResult(result);
            }
            catch (Exception ex)
            {
                ErrorOut(ex.Message);
            }
        }
        else
            ErrorOut(parseResult.ErrorMessage);

        int side;
        if (!int.TryParse(inputSide, out side))
            ErrorOut("Side number not valid!");
        
         if (side % 2 == 0)
            ErrorOut("Side needs to be an odd number!");

        return 0;
    }
}

/*
To compile run in Developer Command Prompt:
> csc *.cs

To execute run in the CLI:
> main
or provie the side:
> main 5
*/
