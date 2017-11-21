#include <stdbool.h>

#define EVEN_SIDE_ERROR 2048

typedef struct {
    bool Success;
    long int Side;
    char ErrorMessage[100];
} ParseSideResult;

typedef struct {
    int **Matrix;
    int Sum;
    int Side;
    bool Success;
} MatrixResult;