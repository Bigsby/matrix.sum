#include <iostream>
#include <string>
#include "console_util.cpp"
#include "matrix_result.cpp"
#include "matrix_calculator.cpp"

using namespace std;

void ErrorOut(string message)
{
    cout << message;
    exit(0);
}

int main(int argc, char *argv[])
{
    string inputSide;
    if (argc == 1)
		inputSide = ConsoleUtil::Prompt("Input side (odd):");
    else
		inputSide = argv[1];

    int side;
    try
    {
		side = stoi(inputSide);
    }
    catch (...)
    {
		ErrorOut("Side number not valid!");
    }

    if (side % 2 == 0)
		ErrorOut("Side needs to be an odd number!");

    MatrixResult result = MatrixCalculator::Calculate(side);

    cout << (result.Success ? "Matrix calculated successfully!" : "Error calculating matrix!!!") << endl;

	ConsoleUtil::DisplayMatrixResult(result);

    return 0;
}

/*
To compile rum:
> cl /EHsc main

To execute run in the CLI:
> main
or provie the side:
> main 7
*/