"use strict";
const calculator = require("./matrixCalculator");
const consoleUtil = require("./consoleUtil");
const results = require("./results");

let side = 0;

function parseSideInput(inputSide) {
    if (/^[0-9]+$/.test(inputSide))
        return new results.parseSideResult(parseInt(inputSide));
    return new results.parseSideResult("Side input not valid!");
}

function errorOut(message) {
    console.log(message);
    process.exit();
}

function handleInput(inputSide) {
    var parseResult = parseSideInput(inputSide);
    if (parseResult.success) {
        try {
            var result = calculator.calculate(parseResult.side);

            console.log(result.success ? "Matrix calculated successfully!" : "Error calculating matrix!!!");

            consoleUtil.displayMatrixResult(result);

        } catch (error) {
            errorOut(error.message);
        }
    } else {
        errorOut(parseResult.errorMessage);
    }
}

function main() {
    var args = process.argv.slice(2);
    if (args.length)
        handleInput(args[0]);
    else
        consoleUtil.prompt("Input side (odd):", handleInput);
}

main();

/*
To execute run in the CLI:
> node main
or provide the side:
> node main 7
*/