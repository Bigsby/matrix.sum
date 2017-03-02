#pragma once
#include <vector>

using std::vector;

class MatrixResult{
    public:
    vector<vector<int>> Matrix;
    int Sum;
    int Side;
    bool Success;

    MatrixResult(vector<vector<int>> matrix, int sum, int side, bool success){
        Matrix = matrix;
        Sum = sum;
        Side = side;
        Success = success;
    }
};