require_relative "consoleUtil"
require_relative "results"
require_relative "matrixCalculator"

def ParseSideInput(inputSide)
    if inputSide =~ /^[0-9]+$/
        return Results::ParseSideResult.new(inputSide.to_i)
    else
        return Results::ParseSideResult.new("Side input not valid!")
    end
end

def ErrorOut(message)
    puts message
    exit
end

inputSide = ""
if ARGV.length == 0
    inputSide = ConsoleUtil.Prompt("Input side (odd):")
else
    inputSide = ARGV[0]
end

parseResult = ParseSideInput(inputSide)

if parseResult.success
    begin
        result = MatrixCalculator.Calculate(inputSide.to_i)
        puts result.success ? "Matrix calculated successfully!" : "Error calculating matrix!!!"
        ConsoleUtil.DisplayMatrixResult(result)
    rescue Exception => ex
        ErrorOut(ex.message)
    end

else
    ErrorOut(parseResult.errorMessage)
end

=begin
To execute run in the CLI:
> ruby main.rb
or provide the side:
> ruby main.rb 7
=end