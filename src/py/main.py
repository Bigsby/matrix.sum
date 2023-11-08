import sys
import re

from consoleUtil import ConsoleUtil
import results
from matrixCalculator import MatrixCalculator

def ParseSideInput(inputSide: str) -> results.ParseSideResult:
    if re.compile("^[0-9]+$").match(inputSide):
        return results.ParseSideResult(int(inputSide))
    else:
        return results.ParseSideResult("Side input not valid!")

def ErroOut(message) -> None:
    print(message)
    sys.exit()

def Main() -> None:
    inputSide = ""
    if len(sys.argv) == 1:
        inputSide = ConsoleUtil.Prompt("Input side (odd):")
    else:
        inputSide = sys.argv[1]

    parseResult = ParseSideInput(inputSide)
    if parseResult.success:
        try:
            result = MatrixCalculator.Calculate(parseResult.side)
            print("Matrix calculated successfully!" if result.success else "Error calculating matrix!!!")
            ConsoleUtil.DisplayMatrixResult(result)
        except Exception as ex:
            ErroOut(ex.args[0])
    else:
        ErroOut(parseResult.errorMessage)
    
Main()

'''
To execute run in the CLI:
> py main.py
or provide the side:
> py main.py 11
'''
