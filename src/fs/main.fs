open System
open System.Text.RegularExpressions
open ConsoleUtil
open MatrixCalculator
open results

let parseSideInput input = 
    if Regex.Match(input, "^[0-9]+$").Success
        then ParseSideSuccess (Int32.Parse input)
        else ParseSideFailure ("Side input not valid!")

let errorOut message =
    printfn "%s" message
    exit |> ignore

[<EntryPoint>]
let main(args) =

    let inputSide =
        match args.Length with
        | 0 -> ConsoleUtil.Prompt "Input side (odd):"
        | _ -> args.[0]

    match parseSideInput inputSide with
    | ParseSideFailure errorMessage -> errorOut errorMessage
    | ParseSideSuccess side ->
        try 
            let matrixResult = MatrixCalculator.Calculate side
            match matrixResult with
            | MatrixFailure -> printfn "Error calculating matrix!!!"
            | MatrixSuccess (matrix, sum, side) ->
                printfn "Matrix calculated successfully!"
                ConsoleUtil.DisplayMatrixResult matrix sum side
        with
           | _ as ex -> errorOut ex.Message

    0

(*
To compile run in Developer Command Prompt:
> fsc consoleUtil.fs results.fs matrixCalculator.fs main.fs

To execute run in the CLI:
> main
or provie the side:
> main 5
*)