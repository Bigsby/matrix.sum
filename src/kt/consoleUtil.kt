import kotlin.math.max

fun prompt(question: String) : String {
    println(question);
    return readLine()!!;
}

fun displayMatrixResult(result: MatrixResult) {
    val matrix = result.matrix
    val side = result.side
    val length = max((side * side).toString().length + 1, 2)

    for (rowIndex in 0..(side - 1)) {
        for (columnIndex in 0..(side - 1)) {
            print("%${length}d".format(matrix[rowIndex][columnIndex]))
        }
        println()
    }
    println("Sum: ${result.sum}")

}
