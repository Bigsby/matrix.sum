Imports Results

Public Module Calculator
    Private Class CurrentHolder
        Private _row As Integer
        Private _column As Integer
        Private _startRow As Integer
        Private _startColumn As Integer
        Private _side As Integer

        Public Sub New(ByVal row As Integer, ByVal column As Integer, ByVal side As Integer)
            Me._row = row
            Me._column = column
            Me._startRow = row
            Me._startColumn = column
            Me._side = side
        End Sub

        Public Sub [Next](ByVal count As Integer)
            If count Mod Me._side <> 0
                Me._row += 1
                Me._column += 1
            Else
                Me._startRow += 1
                Me._row = Me._startRow
                Me._startColumn -= 1
                Me._column = Me._startColumn
            End If
        End Sub

        Public Function ActualRow()
            ActualRow = Actual(Me._row)
        End Function

        Public Function ActualColumn()
            ActualColumn = Actual(Me._column)
        End Function

        Private Function Actual(ByVal value As Integer)
            If value < 0
                Return value + Me._side
            End If

            If value >= Me._side
                Return value - Me._side
            End If
            
            Return value
        End Function

    End Class

    Public Class MatrixCalculator

        Private Shared Function TestResult(ByVal matrix As Integer(,), ByVal expectedSum As Integer, ByVal side As Integer)
            For rowIndex = 0 To side - 1
                Dim sum = 0
                For columnIndex = 0 To side - 1
                    sum += matrix(rowIndex, columnIndex)
                Next columnIndex
                If sum <> expectedSum
                    Return False
                End If
            Next rowIndex

            For columnIndex = 0 To side - 1
                Dim sum = 0
                For rowIndex = 0 To side - 1
                    sum += matrix(rowIndex, columnIndex)
                Next rowIndex
                If sum <> expectedSum
                    Return False
                End If
            Next columnIndex

            Dim diagonalSum = 0
            For diagonalIndex = 0 To side - 1
                diagonalSum += matrix(diagonalIndex, diagonalIndex)
            Next
            If diagonalSum <> expectedSum
                Return False
            End If

            diagonalSum = 0
            For diagonalIndex = 0 To side - 1
                diagonalSum += matrix(diagonalIndex, side - diagonalIndex - 1)
            Next
            
            Return diagonalSum = expectedSum
        End Function

        Private Shared Function CreateEmptyMatrix(ByVal side as Integer)
            Dim matrix(side, side) As Integer
            CreateEmptyMatrix = matrix
        End Function

        Public Shared Function Calculate(ByVal side As Integer)
            If side Mod 2 <> 1
                Throw New System.Exception("Side needs to be an odd number.")
            End If

            Dim expectedSum = side * (side * side + 1) / 2
            Dim matrix = CreateEmptyMatrix(side)
            Dim current = New CurrentHolder(-(side - 1) / 2, (side - 1)/ 2, side)

            For count As Integer = 1 To side * side
                matrix(current.ActualRow(), current.ActualColumn()) = count
                current.Next(count)
            Next

            Calculate = New MatrixResult(matrix, expectedSum, side, TestResult(matrix, expectedSum, side))
        End Function
    End Class
End Module