const readline = require("readline");

String.prototype.padLeft = function (length, character) {
    return String(new Array(length + 1).join(character) + this).slice(-length);
};

module.exports = {
    displayMatrixResult: function (result) {
        var matrix = result.matrix;
        var length = Math.max(Math.pow(result.side, 2).toString().length + 1, 2);

        for (var rowIndex = 0; rowIndex < result.side; rowIndex++) {
            var rowText = "";
            for (var columnIndex = 0; columnIndex < result.side; columnIndex++) {
                rowText += matrix[rowIndex][columnIndex].toString().padLeft(length, " ");
            }
            process.stdout.write(rowText + "\n");
        }

        console.log("Sum: " + result.sum);
    },
    prompt: function (question, callback) {
        var rl = readline.createInterface({
            input: process.stdin,
            output: process.stdout
        });

        rl.question(question + "\n", function (input) {
            rl.close();
            if (callback)
                callback(input);
        });
    }
};