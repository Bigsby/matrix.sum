package main

import "os"
import "fmt"
import "strconv"

import console_util "./console_util"
import matrix_calculator "./matrix_calculator"

func errorOut(message string) {
	fmt.Println(message)
	os.Exit(0)
}

func main() {
	args := os.Args[1:]

	var inputSide = ""
	if len(args) == 1 {
		inputSide = args[0]
	} else {
		inputSide = console_util.Prompt("Input side (odd):")
	}

	side, err := strconv.Atoi(inputSide)
	if err != nil {
		errorOut("Side number not valid!")
	}

	if side%2 == 0 {
		errorOut("Side needs to be an odd number!")
	}

	result, _ := matrix_calculator.Calculate(side)

	if result.Success {
		fmt.Println("Matrix calculated successfully!")
	} else {
		fmt.Println("Error calculating matrix!!!")
	}

	console_util.DisplayMatrixResult(result)
}
