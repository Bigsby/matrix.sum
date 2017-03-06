open System
open System.Text.RegularExpressions
open ConsoleUtil
open MatrixCalculator
open results

let parseSideInput input = 
    let m = Regex.Match(input, "^[0-9]+$")
    if m.Success
        then ParseSideSuccess (System.Int32.Parse input)
        else ParseSideFailure ("Side input not valid!")

let errorOut message =
    printfn "%s" message
    exit

[<EntryPoint>]
let main(args) =

    let inputSide =
        match args.Length with
        | 0 -> ConsoleUtil.Prompt "Input side (odd):"
        | _ -> args.[0]

    //let parseResult = parseSideInput inputSide

    match parseSideInput inputSide with
    | ParseSideFailure errorMessage -> errorOut errorMessage |> ignore
    | ParseSideSuccess side ->
        try 
            MatrixCalculator.Calculate side
        with
           | _ as ex -> errorOut ex.Message |> ignore 

    0

// fsc consoleUtil.fs results.fs matrixCalculator.fs main.fs