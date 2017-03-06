module MatrixCalculator

open System
open results

let createEmtpyMatrix side =
    Array2D.zeroCreate side side

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
            row <- row + 1 //|> ignore
            column <- column + 1 //|> ignore
        else
            startRow <- startRow + 1
            row <- startRow //|> ignore
            startColumn <- startColumn - 1
            column <- startColumn //|> ignore
        |> ignore

let Calculate side = 
    if side % 2 = 0
        then raise (Exception("Side needs to be an odd number."))
    
    let expectedSum = side * (side * side + 1) / 2
    let matrix = createEmtpyMatrix
    let current = new currentHolder (-(side - 1) / 2,(side - 1)/ 2,side)
    
    for count in [1..side*side] do
        printfn "%i" count
    
    printfn "Side is %i" side

