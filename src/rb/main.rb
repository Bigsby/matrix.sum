require_relative "console_util"
require_relative "matrix_calculator"

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

if inputSide =~ /^[0-9]+$/
    result = MatrixCalculator.Calculate(inputSide.to_i)
    ConsoleUtil.DisplayMatrixResult(result)
else
    ErrorOut("Side number not valid!")
end