require_relative "results"

class CurrentHolder
    def initialize(row, column, side)
        @row = @startRow = row
        @column = @startColumn = column
        @side = side
    end

    def row
        @row
    end

    def row=row
        @row = row
    end
    
    def column
        @column
    end

    def column=column
        @column = column
    end

    def startRow
        @startRow
    end

    def startRow=startRow
        @startRow = startRow
    end

    def startColumn
        @startColumn
    end

    def startColumn=startColumn
        @startColumn = startColumn
    end

    def ActualRow
        return Actual(@row)
    end

    def ActualColumn
        return Actual(@column)
    end

    private
    def Actual(value)
        if value < 0
            return value + @side
        elsif value >= @side
            return value - @side
        end

        return value
    end
end

class MatrixCalculator
    def self.Calculate(side)

        if side % 2 != 1
            raise "Side needs to be an odd number."
        end

        expectedSum = side * (side * side + 1) / 2
        matrix = CreateEmptyMatrix(side)
        current = CurrentHolder.new(-(side -1) / 2, (side / 2).floor, side)

        for count in 1..side * side
            matrix[current.ActualRow][current.ActualColumn] = count

            if count % side != 0
                current.row += 1
                current.column += 1
            else
                current.startRow += 1
                current.startColumn -= 1
                current.row = current.startRow
                current.column = current.startColumn
            end
            
        end
        
        return Results::MatrixResult.new(matrix, expectedSum, side, TestResult(matrix, expectedSum, side))
    end

    private
    def self.CreateEmptyMatrix(side)
        return Array.new(side) { Array.new(side) }
    end

    def self.TestResult(matrix, expectedSum, side)
        for rowIndex in 0..side - 1
            sum = 0
            for columnIndex in 0..side - 1
                sum += matrix[rowIndex][columnIndex]
            end
            if sum != expectedSum
                return false
            end
        end

        for columnIndex in 0..side - 1
            sum = 0
            for rowIndex in 0..side - 1
                sum += matrix[rowIndex][columnIndex]
            end
            if sum != expectedSum
                return false
            end
        end
        
        diagonalSum = 0
        for diagonalIndex in 0..side - 1
            diagonalSum += matrix[diagonalIndex][diagonalIndex]
        end
        if diagonalSum != expectedSum
            return false
        end

        diagonalSum = 0
        for diagonalIndex in 0..side - 1
            diagonalSum += matrix[diagonalIndex][side - diagonalIndex - 1]
        end

        diagonalSum == expectedSum
    end
end