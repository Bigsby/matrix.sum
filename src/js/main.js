"use strict";
const readline = require("readline");
const calculator = require("./matrix_calculator");
const console_util = require("./console_util");

let side = 0;

function errorOut(message) {
    console.log(message);
    process.exit();
}

function ask(callback) {
    console_util.prompt("Input side (odd):", function (input) {
        side = parseInt(input);
        if (callback)
            callback();
    });
};

function calculate() {
    if (isNaN(side))
        errorOut("Side number not valid!");
    if (side % 2 == 0)
        errorOut("Side needs to be an odd number!");

    var result = calculator.calculate(side);
    console_util.displayMatrixResult(result);
};

(function () {
    var args = process.argv.slice(2);
    if (args.length) {
        side = parseInt(args[0]);
        calculate();
    }
    else
        ask(calculate);
})();

/*
To execute run in ths CLI:
> node main
or provide the side:
> node main 7
*/