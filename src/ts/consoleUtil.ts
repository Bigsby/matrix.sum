import * as process from "process";
import * as readline from "readline";
import { MatrixResult } from "./results";

function paddLeft(value: string, length: number, character: string) {
    return String(new Array(length + 1).join(character) + value).slice(-length);
};

export class ConsoleUtil {
    static Prompt(question: string): Promise<string> {
        return new Promise((resolve, reject) => {
            var prompt = readline.createInterface({
                input: process.stdin,
                output: process.stdout
            });

            prompt.question(question, answer => {
                prompt.close();
                resolve(answer)
            });
        });
    }

    static DisplayMatrix(result: MatrixResult) {
        var matrix = result.matrix;
        var length = Math.max(Math.pow(result.side, 2).toString().length + 1, 2);

        for (var rowIndex = 0; rowIndex < result.side; rowIndex++) {
            for (var columnIndex = 0; columnIndex < result.side; columnIndex++) {
                process.stdout.write(paddLeft(matrix[rowIndex][columnIndex].toString(), length, " "));
            }
            process.stdout.write("\n");
        }

        console.log("Sum: " + result.sum);
    }
}