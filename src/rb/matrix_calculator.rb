require_relative "matrix_result"

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
        
        return MatrixResult.new(matrix, matrix[0].inject(:+), side)
    end

    private
    def self.CreateEmptyMatrix(side)
        return Array.new(side) { Array.new(side) }
    end
end