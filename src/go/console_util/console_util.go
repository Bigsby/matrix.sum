package console_util

import (
	"bufio"
	"fmt"
	"os"
)

import matrix_calculator "../matrix_calculator"

func Prompt(question string) string {
	fmt.Println(question)
	reader := bufio.NewReader(os.Stdin)
	input, _, _ := reader.ReadLine()
	return string(input)
}

func padLeft(str, pad string, length int) string {
	padding := ""
	for i := 0; i < length-len(str); i++ {
		padding += pad
	}

	return padding + str
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

// DisplayMatrixResult outputs the matrix in the console
func DisplayMatrixResult(result matrix_calculator.MatrixResult) {
	matrix := result.Matrix
	length := max(len(fmt.Sprintf("%d", result.Side*result.Side))+1, 2)

	for rowIndex := 0; rowIndex < result.Side; rowIndex++ {
		rowText := ""
		for columnIndex := 0; columnIndex < result.Side; columnIndex++ {
			rowText += padLeft(fmt.Sprintf("%d", matrix[rowIndex][columnIndex]), " ", length)
		}
		fmt.Println(rowText)
	}

	fmt.Printf("Sum: %v", result.Sum)
}
