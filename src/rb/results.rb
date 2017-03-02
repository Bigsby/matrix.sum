module Results
    class ParseSideResult
        def initialize(value)
            if value.is_a? Integer
                @success = true
                @side = value
            else
                @success = false
                @errorMessage = value
            end
        end

        def success
            @success
        end
        
        def side
            @side
        end
        
        def errorMessage
            @errorMessage
        end
    end

    class MatrixResult
        def initialize(matrix, sum, side, success)
            @matrix = matrix
            @sum = sum
            @side = side
            @success = success
        end

        def matrix
            @matrix
        end

        def sum
            @sum
        end

        def side
            @side
        end

        def success
            @success
        end
    end
end