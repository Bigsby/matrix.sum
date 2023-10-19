#include <stdio.h>
#include <stdlib.h>
#include <errno.h>

#include "./results.h"

typedef struct
{
    int Side;
    int Row;
    int StartRow;
    int Column;
    int StartColumn;
} CurrentHolder;

int **CreateEmptyMatrix(int side)
{
    int *columns = (int *)calloc(side * side, sizeof(int));
    int **rows = (int **)calloc(side, sizeof(int *));
    for (int i = 0; i < side; i++)
        rows[i] = columns + i * side;

    return rows;
}

static int Actual(CurrentHolder *current, int value)
{
    if (value < 0)
        return value + current->Side;

    if (value >= current->Side)
        return value - current->Side;

    return value;
}

static int ActualRow(CurrentHolder *current)
{
    return Actual(current, current->Row);
}

static int ActualColumn(CurrentHolder *current)
{
    return Actual(current, current->Column);
}

static void Next(CurrentHolder *current, int count)
{
    if (count % current->Side != 0)
    {
        current->Row = current->Row + 1;
        current->Column = current->Column + 1;
    }
    else
    {
        current->StartRow = current->StartRow + 1;
        current->Row = current->StartRow;
        current->StartColumn = current->StartColumn - 1;
        current->Column = current->StartColumn;
    }
}

static bool TestResult(int **matrix, int expectedSum, int side)
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

MatrixResult Calculate(int side)
{
    MatrixResult result;
    if (side % 2 == 0)
    {
        errno = EVEN_SIDE_ERROR;
        return result;
    }

    int expectedSum = side * (side * side + 1) / 2;
    result.Sum = expectedSum;
    result.Side = side;

    int **matrix = CreateEmptyMatrix(side);
    CurrentHolder *current = (CurrentHolder *)malloc(sizeof(CurrentHolder));
    current->Row = current->StartRow = -(side - 1) / 2;
    current->Column = current->StartColumn = (side - 1) / 2;
    current->Side = side;

    for (int count = 1; count <= side * side; count++)
    {
        matrix[ActualRow(current)][ActualColumn(current)] = count;

        Next(current, count);
    }
    free(current);

    result.Matrix = matrix;
    result.Success = TestResult(matrix, expectedSum, side);

    return result;
}
