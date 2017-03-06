module results

type ParseSideResult = 
    | ParseSideSuccess of int
    | ParseSideFailure of string

type MatrixResult =
    | MatrixFailure
    | MatrixSuccess of int[,] * int * int