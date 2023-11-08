class ConsoleUtil:
    @staticmethod
    def Prompt(question: str) -> str:
        return input(question + "\n")

    @staticmethod
    def DisplayMatrixResult(result) -> None:
        matrix = result.matrix
        length = max(len(str(result.side * result.side)) + 1, 2)

        for rowIndex in range(result.side):
            rowText = ""
            for columnIndex in range(result.side):
                rowText += str(matrix[rowIndex][columnIndex]).rjust(length)
            
            print(rowText)
        
        print("Sum: " + str(result.sum))

        
