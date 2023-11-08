#include "consoleUtil.cpp"
#include "matrixCalculator.cpp"
#include "results.hpp"
#include <iostream>
#include <regex>
#include <string>

using namespace std;
using namespace results;

ParseSideResult ParseSideInput(string inputSide) {
  if (regex_match(inputSide, regex("^[0-9]+$"))) {
    return ParseSideResult(stoi(inputSide));
  }
  return ParseSideResult("Side input not valid!");
}

void ErrorOut(string message) {
  cout << message;
  exit(0);
}

int main(int argc, char *argv[]) {
  string inputSide;
  if (argc == 1)
    inputSide = ConsoleUtil::Prompt("Input side (odd):");
  else
    inputSide = argv[1];

  ParseSideResult parseResult = ParseSideInput(inputSide);

  if (parseResult.Success) {
    try {

      MatrixResult result = MatrixCalculator::Calculate(parseResult.Side);

      cout << (result.Success ? "Matrix calculated successfully!"
                              : "Error calculating matrix!!!")
           << endl;

      ConsoleUtil::DisplayMatrixResult(result);
    } catch (exception &ex) {
      ErrorOut(ex.what());
    }
  } else {
    ErrorOut(parseResult.ErrorMessage);
  }

  return 0;
}

/*
To compile run:
> cl /EHsc main.cpp

To execute run in the CLI:
> main
or provie the side:
> main 7
*/
