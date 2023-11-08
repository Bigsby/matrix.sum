#pragma once
#include <string>
#include <vector>

using namespace std;

namespace results {
class ParseSideResult {

public:
  bool Success;
  int Side;
  string ErrorMessage;
  ParseSideResult(int side) {
    Side = side;
    Success = true;
  }

  ParseSideResult(string errorMessage) {
    ErrorMessage = errorMessage;
    Success = false;
  }
};

class MatrixResult {
public:
  vector<vector<int>> Matrix;
  int Sum;
  int Side;
  bool Success;

  MatrixResult(vector<vector<int>> matrix, int sum, int side, bool success) {
    Matrix = matrix;
    Sum = sum;
    Side = side;
    Success = success;
  }
};
} // namespace results
