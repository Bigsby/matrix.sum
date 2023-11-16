class ParseResult(
    val value: Int, 
    val error: String,
    val success: Boolean) {
}

class MatrixResult(
    val matrix: Array<Array<Int>>,
    val sum: Int,
    val side: Int,
    val success: Boolean) {
}
