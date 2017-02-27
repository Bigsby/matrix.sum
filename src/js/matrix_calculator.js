const result = require("./matrix_result");

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

    this.actualRow = function () {
        return actual(me.row);
    };

    this.actualColumn = function () {
        return actual(me.column);
    };
};

module.exports = {
    calculate: function (side) {
        if (side % 2 !== 1)
            throw new Error("Side needs to be an odd number.");

        var matrix = createEmptyMatrix(side);
        var current = new currentHolder(-(side - 1) / 2, Math.floor(side / 2), side);

        for (var count = 1; count <= side * side; count++) {
            matrix[current.actualRow()][current.actualColumn()] = count;

            if (count % side != 0) {
                current.row++;
                current.column--;
            }
            else {
                current.row = ++current.startRow;
                current.column = ++current.startColumn;
            }
        }

        return new result(matrix, matrix[0].reduce(function (total, value) {
            return total + value;
        }, 0), side);
    }
}