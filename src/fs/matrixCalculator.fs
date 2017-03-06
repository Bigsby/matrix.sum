module MatrixCalculator

open System
open Microsoft.FSharp.Math
open results

let createEmtpyMatrix side =
    Array2D.create side side 0

type currentHolder(row, column, side) =
    let mutable row = row
    let mutable column = column
    let mutable startRow = row
    let mutable startColumn = column
    let side = side

    let actual value =
        match (value, side) with
            | (x, y) when x < 0 -> x + y
            | (x, y) when x >= y -> x - y
            | _ -> value

    member this.ActualRow = actual row
    member this.ActualColumn = actual column
    member this.Next count =
        if count % side <> 0
        then
            row <- row + 1
            column <- column + 1
        else
            startRow <- startRow + 1
            row <- startRow
            startColumn <- startColumn - 1
            column <- startColumn
        |> ignore

let testResult (matrix:int[,]) expectedSum side =
    let mutable result = true
    let indexEnd = side - 1
    let indexes = [0..indexEnd]
    
    for rowIndex in indexes do
        if (Array.sum matrix.[rowIndex,0..indexEnd]) <> expectedSum
        then result <- false

    for columnIndex in indexes do
        if (Array.sum matrix.[0..indexEnd, columnIndex]) <> expectedSum
        then result <- false

    let mutable diagonalSum = 0
    for diagonalIndex in indexes do
        diagonalSum <- diagonalSum + matrix.[diagonalIndex, diagonalIndex]

    if diagonalSum <> expectedSum
       then result <- false

    diagonalSum <- 0
    for diagonalIndex in indexes do
        diagonalSum <- diagonalSum + matrix.[diagonalIndex, side - diagonalIndex - 1]

    result && (diagonalSum = expectedSum)


let Calculate side = 
    if side % 2 = 0
        then raise (Exception("Side needs to be an odd number."))
    
    let expectedSum = side * (side * side + 1) / 2
    let matrix = createEmtpyMatrix side
    let current = new currentHolder (-(side - 1) / 2, (side - 1)/ 2, side)
    
    for count in [1..side*side] do
        matrix.[current.ActualRow, current.ActualColumn] <- count
        current.Next count

    let result = testResult matrix expectedSum side
    
    if result
    then MatrixSuccess (matrix, expectedSum, side)
    else MatrixFailure

