Imports System

Public Class ConsoleUtil
    Public Shared Function Prompt(ByVal question As String)
        Console.WriteLine(question)
        Prompt = Console.ReadLine()
    End Function

    Public Shared Sub DisplayMatrixResult(ByVal result As Results.MatrixResult)
        Dim matrix = result.Matrix
        Dim length = Math.Max((result.Side * result.Side).ToString().Length + 1, 2)

        For rowIndex = 0 To result.Side - 1
            Dim rowText = ""
            For columnIndex = 0 To result.Side -1
                rowText += matrix(rowIndex, columnIndex).ToString().PadLeft(length, " ")
            Next columnIndex
            Console.WriteLine(rowText)
        Next rowIndex

        Console.Write($"Sum: {result.Sum}")
    End Sub
End Class