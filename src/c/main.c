#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <errno.h>

#include "./results.h"
#include "./consoleUtil.h"
#include "./matrixCalculator.h"

void ErrorOut(char *message);
ParseSideResult ParseSideInput(char *inputSide);

int main(int argc, char *argv[])
{
    char userInput[100];
    if (argc != 2)
        Prompt("Input side (odd):", userInput);
    else
        strcpy(userInput, argv[1]);

    ParseSideResult parseResult;
    parseResult = ParseSideInput(userInput);
    
    MatrixResult result;
    if (parseResult.Success)
        result = Calculate(parseResult.Side);
    else
        ErrorOut(parseResult.ErrorMessage);

    if (errno == EVEN_SIDE_ERROR)
    {
        printf("Side needs to be an odd number.\n");
    }
    else
    {
        if (result.Success)
        {
            printf("Matrix calculated successfully!\n");
            DisplayMatrixResult(result);
        }
        else
        {
            printf("Error calculating matrix!!!\n");
        }
    }

    return 0;
}

void ErrorOut(char *message)
{
    printf("%s", message);
    exit(0);
}

ParseSideResult ParseSideInput(char *inputSide)
{
    ParseSideResult result;
    char *endpointer;
    long sideResult;

    sideResult = strtol(inputSide, &endpointer, 10);
    
    if (*endpointer != '\n' && *endpointer != 0)
    {
        result.Success = false;
        strcpy(result.ErrorMessage, "Side input not valid!\n");
    }
    else
    {
        result.Success = true;
        result.Side = sideResult;
    }

    return result;
}

/*
To compile run:
> gcc main.c consoleUtil.c matrixCalculator.c

To execute run in the CLI:
> ./a.out
or provie the side:
> ./a.out 7
*/
