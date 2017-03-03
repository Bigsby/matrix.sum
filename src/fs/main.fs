open ConsoleUtil


[<EntryPoint>]
let main(args) =
    let mutable inputSide = ""

    if args.Length = 0
    then inputSide <- ConsoleUtil.Prompt "Input side (odd):"
    else inputSide <- args.[0]
    
    printfn "Input %A" inputSide

    0

