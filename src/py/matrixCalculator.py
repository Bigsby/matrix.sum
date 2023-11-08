from typing import List
import results

Matrix = List[List[int]]

class _CurrentHolder:
    def __init__(self, row: int, column: int, side: int):
        self.row = self.startRow = row
        self.column = self.startColumn = column
        self.__side = side

    def __Actual(self, value: int) -> int:
        if value < 0:
            return value + self.__side
        
        if value >= self.__side:
            return value - self.__side

        return value

    def ActualRow(self) -> int:
        return self.__Actual(self.row)
    
    def ActualColumn(self) -> int:
        return self.__Actual(self.column)

    def Next(self, count: int) -> None:
        if count % self.__side != 0:
            self.row += 1
            self.column += 1
        else:
            self.startRow += 1
            self.startColumn -= 1
            self.row = self.startRow
            self.column = self.startColumn

class MatrixCalculator:
    @staticmethod
    def __TestResult(matrix: Matrix, expectedSum: int, side: int) -> bool:
        for rowIndex in range(0, side):
            sum = 0
            for columnIndex in range(0, side):
                sum += matrix[rowIndex][columnIndex]
            
            if sum != expectedSum:
                return False
        
        for columnIndex in range(0, side):
            sum = 0
            for rowIndex in range(0, side):
                sum += matrix[rowIndex][columnIndex]
            
            if sum != expectedSum:
                return False

        diagonalSum = 0
        for diagonalIndex in range(0, side):
            diagonalSum += matrix[diagonalIndex][diagonalIndex]

        if diagonalSum != expectedSum:
            return False
        
        diagonalSum = 0
        for diagonalIndex in range(0, side):
            diagonalSum += matrix[diagonalIndex][side - diagonalIndex - 1]
        
        return diagonalSum == expectedSum

    @staticmethod
    def __CreateEmptyMatrix(side: int) -> Matrix:
        return [[0 for _ in range(side)] for _ in range(side)] 

    @staticmethod
    def Calculate(side: int) -> results.MatrixResult:
        if side % 2 != 1:
            raise Exception("Side needs to be an odd number.")

        expectedSum = side * (side * side + 1) // 2
        matrix = MatrixCalculator.__CreateEmptyMatrix(side)
        current = _CurrentHolder(-(side - 1) // 2, side // 2, side)

        for count in range(1, side * side + 1):
            matrix[current.ActualRow()][current.ActualColumn()] = count
            
            current.Next(count)
            

        return results.MatrixResult(matrix, expectedSum, side, MatrixCalculator.__TestResult(matrix, expectedSum, side))
