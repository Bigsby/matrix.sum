#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <iomanip>
#include "results.cpp"

using namespace std;

class ConsoleUtil
{
  public:
    static string Prompt(string question)
    {
        cout << question << endl;
        string result;
        cin >> result;
        return result;
    }

    static void DisplayMatrixResult(results::MatrixResult result)
    {
        vector<vector<int>> matrix = result.Matrix;
        int length = max(to_string(result.Side * result.Side).length() + 1, static_cast<unsigned int>(2));

        for (int rowIndex = 0; rowIndex < result.Side; rowIndex++)
        {
            for (int columnIndex = 0; columnIndex < result.Side; columnIndex++)
                cout << setw(length) << matrix[rowIndex][columnIndex];
            cout << endl;
        }
        cout << "Sum: " << result.Sum;
    }
};