class ConsoleUtil:
    def Prompt(question):
        return input(question + "\n")

    def DisplayMatrixResult(result, side):
        matrix = result.matrix
        length = max(len(str(side * side)) + 1, 2)

        for rowIndex in range(side):
            rowText = ""
            for columnIndex in range(side):
                rowText += str(matrix[rowIndex][columnIndex]).rjust(length)
            
            print(rowText)
        
        print("Sum: " + str(result.sum))

        