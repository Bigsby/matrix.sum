package matrixCalculator

import (
	"errors"
)

func CreateEmptyMatrix(side int) [][]int {
	result := [][]int{}
	for rowIndex := 0; rowIndex < side; rowIndex++ {
		row := []int{}
		for columnIndex := 0; columnIndex < side; columnIndex++ {
			row = append(row, 0)
		}
		result = append(result, row)
	}
	return result
}

type currentHolder struct {
	Row         int
	Column      int
	side        int
	StartRow    int
	StartColumn int
}

func (current *currentHolder) actual(value int) int {
	if value < 0 {
		return value + current.side
	} else if value >= current.side {
		return value - current.side
	}

	return value
}

func (current *currentHolder) actualRow() int {
	return current.actual(current.Row)
}

func (current *currentHolder) actualColumn() int {
	return current.actual(current.Column)
}

// Calculate calculates the matrix
func Calculate(side int) (MatrixResult, error) {
	if side%2 != 1 {
		return MatrixResult{}, errors.New("side needs to be an odd number")
	}

	expectedSum := side * (side*side + 1) / 2
	matrix := CreateEmptyMatrix(side)
	current := currentHolder{
		-(side - 1) / 2,
		(side - 1) / 2,
		side,
		-(side - 1) / 2,
		(side - 1) / 2}

	for count := 1; count <= side*side; count++ {
		matrix[current.actualRow()][current.actualColumn()] = count

		if count%side != 0 {
			current.Row++
			current.Column++
		} else {
			current.StartRow++
			current.Row = current.StartRow
			current.StartColumn--
			current.Column = current.StartColumn
		}
	}

	return MatrixResult{matrix, expectedSum, side, true}, nil
}
