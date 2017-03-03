module results

type public ParseSideResult(success:bool, side:int, errorMessage:string) = class
    member this.Success: bool = success
    member this.Side: int = side
    member this.ErrorMessage: string = errorMessage
    new(success:bool, side:int, errorMessage:string) = {
        Success = success
        Side = side
        ErrorMessage = errorMessage}
    

    // member val success with get() : bool
    // member val side with get() : int
    // member val errorMesssage with get() : string
    
    // member this.Success with get() = success
    // member this.Side with get() = side
    // member this.ErrorMessage with get() = errorMessage
    // let success: bool = false
    // let Side: int = 0
    // let ErrorMessage: string = ""
    // new (side:int) as this =
    //     Success = true |> ignore
    //     Side = side |> ignore
    // new (errorMessage:string) =
    //     Success = false |> ignore
    //     ErrorMessage = errorMessage |> ignore
end