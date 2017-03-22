"use strict";
class BaseResult {
    constructor(success) {
        this.success = success;
    }
}

module.exports = {
    ParseSideResult: class ParseSideResult extends BaseResult {
        constructor(value) {
            let isNumber = typeof value === "number";
            super(isNumber);
            if (isNumber) {
                this.side = value;
            } else {
                this.errorMessage = value;
            }
        }
    },

    MatrixResult: class MatrixResult extends BaseResult {
        constructor(matrix, sum, side, success) {
            super(success);
            this.matrix = matrix;
            this.sum = sum;
            this.side = side;
            this.success = success;
        }
    }
}