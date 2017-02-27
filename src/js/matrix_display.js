String.prototype.paddingLeft = function (character, length) {
    return String(new Array(length + 1).join(character) + this).slice(-length);
};

module.exports = {
    display: function (result) {
        var matrix = result.matrix;
        var length = Math.max(Math.pow(matrix.length, 2).toString().length + 1, 2);

        for (var rowIndex = 0; rowIndex < matrix.length; rowIndex++) {
            var rowText = "";
            for (var columnIndex = 0; columnIndex < matrix.length; columnIndex++) {
                rowText += matrix[rowIndex][columnIndex].toString().paddingLeft(" ", length);
            }
            process.stdout.write(rowText + "\n");
        }

        console.log("Sum: " + result.sum);
    }
};