import sys
from console_util import ConsoleUtil
from matrix_result import MatrixResult
from matrix_calculator import MatrixCalculator

def ErroOut(message):
    print(message)
    sys.exit()

inputSide = ""
side = 0
if len(sys.argv) == 1:
    inputSide = ConsoleUtil.Prompt("Input side (odd):")
else:
    inputSide = sys.argv[1]

try:
    side = int(inputSide)
except ValueError:
    ErroOut("Side number not valid!")

if side % 2 == 0:
    ErroOut("Side needs to be an odd number!")

result = MatrixCalculator.Calculate(side)
print("Matrix calculated successfully!" if result.success else "Error calculating matrix!!!")
ConsoleUtil.DisplayMatrixResult(result, side)

'''
To execute run in the CLI:
> py main.py
or provide the side:
> py main.py 11
'''