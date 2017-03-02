class ConsoleUtil
    def self.Prompt(question)
        puts question
        return gets
    end

    def self.DisplayMatrixResult(result)
        matrix = result.matrix
        length = [(result.side * result.side).to_s.length + 1, 2].max
        

        matrix.each { |row|
            rowText = ""
            row.each { |column|
                rowText += column.to_s.rjust(length)
            }
            puts rowText
        }
        puts "Sum: #{result.sum}"
    end
    
end