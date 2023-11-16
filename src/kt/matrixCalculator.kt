class CurrentHolder(var row: Int, var column: Int, val side: Int) {
    var startRow: Int
    var startColumn: Int
    init {
        this.startRow = this.row
        this.startColumn = this.column
    }

    private fun actual(value: Int) : Int {
        if (value < 0) {
            return value + this.side;
        }
        if (value >= side) {
            return value - this.side;
        }
        return value
    }

    fun actualRow() : Int {
        return actual(this.row)
    }

    fun actualColumn() : Int {
        return actual(this.column)
    }

    fun next(count: Int) {
        if (count % this.side != 0) {
                this.row += 1
                this.column += 1
        } else {
            this.startRow += 1
            this.row = this.startRow
            this.startColumn -= 1
            this.column = this.startColumn
        }
    }
}

fun createEmptyMatrix(side: Int) : Array<Array<Int>> {
    return Array(side) { Array(side) {0} }
}

fun testResult(matrix: Array<Array<Int>>, expectedSum: Int, side: Int) : Boolean {
    var sum: Int
    for (rowIndex in 0..(side - 1)) {
        sum = 0
        for (columnIndex in 0..(side - 1)) {
            sum += matrix[rowIndex][columnIndex]
        }
        if (sum != expectedSum)
            return false;
    }

    for (columnIndex in 0..(side - 1)) {
        sum = 0
        for (rowIndex in 0..(side - 1)) {
            sum += matrix[rowIndex][columnIndex]
        }
        if (sum != expectedSum)
            return false
    }

    sum = 0
    for (diagonalIndex in 0..(side - 1)) {
        sum += matrix[diagonalIndex][diagonalIndex]
    }
    return sum == expectedSum
}


fun calculate(side: Int) : MatrixResult {
    if (side % 2 != 1) {
        throw Exception("Side needs to be an odd number.")
    }

    val expectedSum = side * (side * side + 1) / 2;
    var matrix = createEmptyMatrix(side)
    var current = CurrentHolder(-(side - 1) / 2, (side - 1) / 2, side)

    for (count in 1..(side * side)) {
        matrix[current.actualRow()][current.actualColumn()] = count
        current.next(count) }

    return MatrixResult(matrix, expectedSum, side, testResult(matrix, expectedSum, side))
}
