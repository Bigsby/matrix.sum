class ParseSideResult:
    def __init__(self, value):
        if isinstance(value, int):
            self.success = True
            self.side = value
        else:
            self.success = False
            self.errorMessage = value

class MatrixResult:
    def __init__(self, matrix, sum, side, success):
        self.matrix = matrix
        self.sum = sum
        self.side = side
        self.success = success