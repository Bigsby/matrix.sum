import results

class _CurrentHolder:
    def __init__(self, row, column, side):
        self.row = self.startRow = row
        self.column = self.startColumn = column
        self.__side = side

    def __Actual(self, value):
        if value < 0:
            return value + self.__side
        
        if value >= self.__side:
            return value - self.__side

        return value

    def ActualRow(self):
        return self.__Actual(self.row)
    
    def ActualColumn(self):
        return self.__Actual(self.column)

class MatrixCalculator:
    @staticmethod
    def __TestResult(matrix, expectedSum, side):
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
    def __CreateEmptyMatrix(side):
        return [[0 for x in range(side)] for y in range(side)] 

    @staticmethod
    def Calculate(side):
        if side % 2 != 1:
            raise Exception("Side needs to be an odd number.")

        expectedSum = side * (side * side + 1) // 2
        matrix = MatrixCalculator.__CreateEmptyMatrix(side)
        current = _CurrentHolder(-(side - 1) // 2, side // 2, side)

        for count in range(1, side * side + 1):
            matrix[current.ActualRow()][current.ActualColumn()] = count

            if count % side != 0:
                current.row += 1
                current.column += 1
            else:
                current.startRow += 1
                current.startColumn -= 1
                current.row = current.startRow
                current.column = current.startColumn

        return results.MatrixResult(matrix, expectedSum, side, MatrixCalculator.__TestResult(matrix, expectedSum, side))