const results = require("./results");

function createEmptyMatrix(side) {
    var result = new Array(side);

    for (var rowIndex = 0; rowIndex < side; rowIndex++)
        result[rowIndex] = new Array(side);

    return result;
};

function currentHolder(row, column, side) {
    var me = this;
    me.row = me.startRow = row;
    me.column = me.startColumn = column;
    me.side = side;

    function actual(value) {
        if (value < 0)
            return value + me.side;
        if (value >= me.side)
            return value - me.side;
        return value;
    };

    me.actualRow = function () {
        return actual(me.row);
    };

    me.actualColumn = function () {
        return actual(me.column);
    };

    me.next = function (count) {
        if (count % me.side != 0) {
            me.row++;
            me.column++;
        }
        else {
            me.row = ++me.startRow;
            me.column = --me.startColumn;
        }
    };
};

function testResult(matrix, expectedSum, side) {
    for (var rowIndex = 0; rowIndex < side; rowIndex++) {
        var sum = 0;
        for (var columnIndex = 0; columnIndex < side; columnIndex++)
            sum += matrix[rowIndex][columnIndex];

        if (sum != expectedSum)
            return false;
    }

    for (var columnIndex = 0; columnIndex < side; columnIndex++) {
        var sum = 0;
        for (var rowIndex = 0; rowIndex < side; rowIndex++)
            sum += matrix[rowIndex][columnIndex];

        if (sum != expectedSum)
            return false;
    }

    var diagonalSum = 0;
    for (var diagonalIndex = 0; diagonalIndex < side; diagonalIndex++)
        diagonalSum += matrix[diagonalIndex][diagonalIndex];

    if (diagonalSum != expectedSum)
        return false;

    diagonalSum = 0;
    for (var diagonalIndex = 0; diagonalIndex < side; diagonalIndex++)
        diagonalSum += matrix[diagonalIndex][side - diagonalIndex - 1];

    return diagonalSum == expectedSum;
}

module.exports = {
    calculate: function (side) {
        if (side % 2 !== 1)
            throw new Error("Side needs to be an odd number.");

        var expectedSum = side * (side * side + 1) / 2;
        var matrix = createEmptyMatrix(side);
        var current = new currentHolder(-(side - 1) / 2, Math.floor(side / 2), side);

        for (var count = 1; count <= side * side; count++) {
            matrix[current.actualRow()][current.actualColumn()] = count;

            current.next(count);
        }

        return new results.matrixResult(matrix, expectedSum, side, testResult(matrix, expectedSum, side));
    }
}