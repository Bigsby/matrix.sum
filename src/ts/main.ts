import * as process from "process";
import { ConsoleUtil } from "./consoleUtil";
import { ParseSideResult } from "./results";
import { calculate } from "./matrixCalculator";

function errorOut(message: string) {
    process.stdout.write(message);
    process.exit();
}

function parseSideInput(inputSide: string): ParseSideResult {
    if (/^[0-9]+$/.test(inputSide))
        return ParseSideResult.Successful(parseInt(inputSide));
    return ParseSideResult.Failure("Side input not valid!");
}

function handleInputSide(inputSide: string) {
    let parseResult = parseSideInput(inputSide);
    if (parseResult.success) {

        try {
            let result = calculate(parseResult.side);
            process.stdout.write(result.success ? "Matrix calculated successfully!\n" : "Error calculating matrix!!!\n");

            ConsoleUtil.DisplayMatrix(result);
        }
        catch (error) {
            errorOut(error.message);
        }
    }
    else
        errorOut(parseResult.errorMessage);
}

function main(args: string[]) {
    if (args.length == 2)
        ConsoleUtil.Prompt("Input side (odd):\n").then(handleInputSide);
    else
        handleInputSide(args[2]);
}

main(process.argv);