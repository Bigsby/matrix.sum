module ConsoleUtil

open System

let Prompt (question:string) : string =
    Console.WriteLine question
    Console.ReadLine()
    
let DisplayMatrixResult (matrix:int[,]) sum side =
    let length = max (String.length (sprintf "%i" (side * side)) + 1) 2
    let indexes = [0..(side - 1)]

    for rowIndex in indexes do
        for columnIndex in indexes do
            printf "%s" ((sprintf "%i" matrix.[rowIndex, columnIndex]).PadLeft(length,' '))
        printfn ""

    printfn "Sum: %i" sum