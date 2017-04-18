import * as process from "process";
import { MatrixResult } from "./results";

function createEmptyMatrix(side: number) {
    let result = new Array(side);

    for (var rowIndex = 0; rowIndex < side; rowIndex++)
        result[rowIndex] = new Array(side);

    return result;
};

class CurrentHolder {
    private startRow: number;
    private startColumn: number;
    private side: number;
    constructor(public row: number, public column: number, side: number) {
        this.row = this.startRow = row;
        this.column = this.startColumn = column;
        this.side = side;
    }

    actual(value: number) {
        if (value < 0)
            return value + this.side;
        if (value >= this.side)
            return value - this.side;
        return value;
    }

    get actualRow() { return this.actual(this.row); }
    get actualColumn() { return this.actual(this.column); }

    next(count:number) {
        if (count % this.side != 0) {
            this.row++;
            this.column++;
        }
        else {
            this.row = ++this.startRow;
            this.column = --this.startColumn;
        }
    }
}

function testResult(matrix: number[][], expectedSum:number, side:number):boolean {
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

export function calculate(side: number): MatrixResult {

    if (side % 2 !== 1)
        throw new Error("Side needs to be an odd number.");

    let expectedSum = side * (side * side + 1) / 2;
    let matrix = createEmptyMatrix(side);
    let current = new CurrentHolder(-(side - 1) / 2, Math.floor(side / 2), side);

    for (let count = 1; count <= side * side; count++) {
        matrix[current.actualRow][current.actualColumn] = count;

        current.next(count);
    }

    return new MatrixResult(matrix, expectedSum, side, testResult(matrix, expectedSum, side));
}