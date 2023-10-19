#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "./results.h"

void Prompt(char *question, char *result) {
    printf("%s\n", question);
    fgets(result, 100, stdin);
}

void DisplayMatrixResult(MatrixResult result) {
    char maxString[10];
    sprintf(maxString, "%d", result.Side * result.Side);
    int maxLength = strlen(maxString) + 1;
    int length = maxLength > 2 ? maxLength : 2;

    for (int row = 0; row < result.Side; row++) {
        for (int column = 0; column < result.Side; column++) {
            printf("%*d", length, result.Matrix[row][column]);
        }
        printf("\n");
    }

    printf("Sum: %d\n", result.Sum);
}
