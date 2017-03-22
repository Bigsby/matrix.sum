"use strict";
const results = require("./results");
const calculator = require("./matrixCalculator");
const consoleUtil = require("./consoleUtil");

function parseSideInput(inputSide) {
    if (/^[0-9]+$/.test(inputSide))
        return new results.ParseSideResult(parseInt(inputSide));
    return new results.ParseSideResult("Side input not valid!");
}

let errorOut = function(message) {
    console.log(message);
    process.exit();
}

let handleInput = (inputSide) => {
    var parseResult = parseSideInput(inputSide);
    if (parseResult.success) {
        try {
            var result = calculator(parseResult.side);

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