[<EntryPoint>]
let main(args) =
    if args.Length = 0
    then printfn "Not Args"
    else printfn "First: %A" args.[0]
    0