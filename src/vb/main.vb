Imports System
Imports System.Text.RegularExpressions
Imports Results
Imports Calculator

Public Module Program
    Function ParseSideInput(ByVal inputSide as String)
        If New Regex("^[0-9]+$").IsMatch(inputSide)
            Return New ParseSideResult(Convert.ToInt32(inputSide))
        Else
            Return New ParseSideResult("Side input not valid!")
        End If
    End Function

    Sub ErrorOut(ByVal message as String)
        Console.WriteLine(message)
        Environment.Exit(0)
    End Sub

    Sub Main()
        Dim args as String() = Environment.GetCommandLineArgs()
        Dim inputSide as String = String.Empty

        IF args.Length = 1
            inputSide = ConsoleUtil.Prompt("Input side (odd):")
        Else
            inputSide = args(1)
        End If

        Dim parseResult = ParseSideInput(inputSide)

        IF parseResult.Success
            Try
                Dim result = MatrixCalculator.Calculate(parseResult.Side)
                Console.WriteLine(iif(result.Success, "Matrix calculated successfully!", "Error calculating matrix!!!"))
                ConsoleUtil.DisplayMatrixResult(result)
            Catch ex As Exception
                ErrorOut(ex.Message)
            End Try
        Else
            ErrorOut(parseResult.ErrorMessage)
        End If
        
    End Sub
End Module

' To compile run in Developer Command Prompt:
' > vbc main.vb results.vb consoleUtil.vb matrixCalculator.vb

' To execute run in the CLI:
' > main
' or provie the side:
' > main 5