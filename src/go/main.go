package main

import "os"
import "regexp"
import "fmt"
import "strconv"

import console_util "./consoleUtil"
import results "./results"
import matrix_calculator "./matrixCalculator"

func parseSideInput(inputSide string) *results.ParseSideResult {
	matched, err := regexp.MatchString("^[0-9]+$", inputSide)
	if matched && err == nil {
		side, _ := strconv.Atoi(inputSide)
		return results.SuccessfulParseSideResult(side)
	}

	return results.FailedParseSideResult("Side input not valid!")
}

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

	parseResult := parseSideInput(inputSide)
	if parseResult.Success {
		result, err := matrix_calculator.Calculate(parseResult.Side)

		if err != nil {
			errorOut(err.Error())
		}

		if result.Success {
			fmt.Println("Matrix calculated successfully!")
		} else {
			fmt.Println("Error calculating matrix!!!")
		}

		console_util.DisplayMatrixResult(result)
	} else {
		errorOut(parseResult.ErrorMessage)
	}
}

/*
To execute run in the CLI:
> go run main.go
or provide the side:
> go run main.go 7
*/
