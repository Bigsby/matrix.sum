module ConsoleUtil
open System

let Prompt (question:string) : string =
    Console.WriteLine question
    Console.ReadLine()
    