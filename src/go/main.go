package main

import "os"
import "regexp"
import "fmt"
import "strconv"

import "matrix/results"
import "matrix/consoleUtil"
import "matrix/matrixCalculator"

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
		inputSide = consoleUtil.Prompt("Input side (odd):")
	}

	parseResult := parseSideInput(inputSide)
	if parseResult.Success {
		result, err := matrixCalculator.Calculate(parseResult.Side)

		if err != nil {
			errorOut(err.Error())
		}

		if result.Success {
			fmt.Println("Matrix calculated successfully!")
		} else {
			fmt.Println("Error calculating matrix!!!")
		}

		consoleUtil.DisplayMatrixResult(result)
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
