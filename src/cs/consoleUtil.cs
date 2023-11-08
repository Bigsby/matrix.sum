using System;
using static System.Console;

public static class ConsoleUtil 
{
    public static string? Prompt(string question)
    {
        WriteLine(question);
        return ReadLine();
    }

    public static void DisplayMatrixResult(Results.MatrixResult  result)
    {
        var matrix = result.Matrix;
        var length = Math.Max(Math.Pow(result.Side, 2).ToString().Length + 1, 2);

        for (var rowIndex = 0; rowIndex < result.Side; rowIndex++) {
            var rowText = "";
            for (var columnIndex = 0; columnIndex < result.Side; columnIndex++) {
                rowText += matrix[rowIndex, columnIndex].ToString().PadLeft(length, ' ');
            }
            WriteLine(rowText);
        }

        WriteLine("Sum: " + result.Sum);
    }
}
