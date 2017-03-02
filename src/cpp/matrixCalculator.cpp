#include <exception>
#include <vector>
#include <iostream>
#include "matrixResult.cpp"

class CurrentHolder
{
    int _side;

    int Actual(int value)
    {
        if (value < 0)
            return value + _side;
        if (value >= _side)
            return value - _side;
        return value;
    }

  public:
    int Row, Column, StartRow, StartColumn, Side;
    CurrentHolder(int row, int column, int side)
    {
        Row = StartRow = row;
        Column = StartColumn = column;
        _side = side;
    }

    int ActualRow()
    {
        return Actual(Row);
    }

    int ActualColumn()
    {
        return Actual(Column);
    }
};

class MatrixCalculator
{
    static vector<vector<int>> CreateEmptyMatrix(int side)
    {
        vector<vector<int>> result;
        result.resize(side);
        for (int rowIndex = 0; rowIndex < side; rowIndex++)
            result[rowIndex].resize(side);

        return result;
    }

    static bool TestResult(vector<vector<int>> matrix, int expectedSum, int side)
    {
        for (int rowIndex = 0; rowIndex < side; rowIndex++)
        {
            int sum = 0;
            for (int columnIndex = 0; columnIndex < side; columnIndex++)
                sum += matrix[rowIndex][columnIndex];

            if (sum != expectedSum)
                return false;
        }

        for (int columnIndex = 0; columnIndex < side; columnIndex++)
        {
            int sum = 0;
            for (int rowIndex = 0; rowIndex < side; rowIndex++)
                sum += matrix[rowIndex][columnIndex];

            if (sum != expectedSum)
                return false;
        }

        int diagonalSum = 0;
        for (int diagonalIndex = 0; diagonalIndex < side; diagonalIndex++)
            diagonalSum += matrix[diagonalIndex][diagonalIndex];

        if (diagonalSum != expectedSum)
            return false;

        diagonalSum = 0;
        for (int diagonalIndex = 0; diagonalIndex < side; diagonalIndex++)
            diagonalSum += matrix[diagonalIndex][side - diagonalIndex - 1];

        return diagonalSum == expectedSum;
    }

  public:
    static MatrixResult Calculate(int side)
    {
        if (side % 2 != 1)
        {
            throw exception("Side needs to be an odd number.");
        }

        int expectedSum = side * (side * side + 1) / 2;
        vector<vector<int>> matrix = CreateEmptyMatrix(side);
        CurrentHolder current(-(side - 1) / 2, (side - 1) / 2, side);

        for (int count = 1; count <= side * side; count++)
        {
            matrix[current.ActualRow()][current.ActualColumn()] = count;

            if (count % side != 0)
            {
                current.Row++;
                current.Column++;
            }
            else
            {
                current.Row = ++current.StartRow;
                current.Column = --current.StartColumn;
            }
        }

        return MatrixResult(matrix, expectedSum, side, TestResult(matrix, expectedSum, side));
    }
};