import kotlin.system.exitProcess

fun parseInput(input: String) : ParseResult {
    try {
        return ParseResult(input.toInt(), "", true)
    }
    catch (e: Exception) {
        return ParseResult(0, "Invalid input", false)
    }

}

fun errorOut(message: String) {
    println(message)
    exitProcess(1)
}

fun main(args: Array<String>) {
    var input: String
    if (args.size == 1) {
        input = args[0]
    }
    else {
        input = prompt("Input size: ")
    }
    val parseResult = parseInput(input)
    if (!parseResult.success) 
        errorOut(parseResult.error)
    val result = calculate(parseResult.value)
    println(if (result.success) "Matrix calculated successfully!" else "Error calculating matrix!!!")
    if (result.success)
        displayMatrixResult(result)

}
