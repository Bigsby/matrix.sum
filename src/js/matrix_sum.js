const readline = require("readline");
const calculator = require("./matrix_calculator");
const display = require("./matrix_display");

function ask() {
    var rl = readline.createInterface({
        input: process.stdin,
        output: process.stdout
    });

    rl.question("Input side (odd):", function (input) {
        rl.close();
        var side = parseInt(input);

        if (side % 2 == 0) {
            console.log("Side not odd!");
            process.exit();
        }

        var result = calculator.calculate(side);
        display.display(result);
    });
}

//ask();

var result = calculator.calculate(5);
display.display(result);