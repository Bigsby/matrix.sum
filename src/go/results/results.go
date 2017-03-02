package results

// MatrixResult holds the result of the matrix calculation
type MatrixResult struct {
	Matrix  [][]int
	Sum     int
	Side    int
	Success bool
}

// ParseSideResult holds the result of parsing input side
type ParseSideResult struct {
	Success      bool
	Side         int
	ErrorMessage string
}

func createParseSideResult(success bool, side int, errorMessage string) *ParseSideResult {
	result := new(ParseSideResult)
	result.Success = success
	result.Side = side
	result.ErrorMessage = errorMessage

	return result
}

// SuccessfulParseSideResult creates an instance of successful parse result
func SuccessfulParseSideResult(side int) *ParseSideResult {
	return createParseSideResult(true, side, "")
}

// FailedParseSideResult creates an instance of falied parse result
func FailedParseSideResult(errorMessage string) *ParseSideResult {
	return createParseSideResult(false, 0, errorMessage)
}
