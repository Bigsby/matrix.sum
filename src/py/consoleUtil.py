class ConsoleUtil:
    def Prompt(question):
        return input(question + "\n")

    def DisplayMatrixResult(result):
        matrix = result.matrix
        length = max(len(str(result.side * result.side)) + 1, 2)

        for rowIndex in range(result.side):
            rowText = ""
            for columnIndex in range(result.side):
                rowText += str(matrix[rowIndex][columnIndex]).rjust(length)
            
            print(rowText)
        
        print("Sum: " + str(result.sum))

        