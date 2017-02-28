package main

import "os"
import "fmt"
import "bufio"

func main(){
    args := os.Args[1:]

    if len(args) == 1 {
        fmt.Println(args[0])
    } else {
        fmt.Println("No args")
    }

    fmt.Println("Input something: ")
    reader := bufio.NewReader(os.Stdin)
    input, _, _ := reader.ReadLine()
    fmt.Println(string(input))
}