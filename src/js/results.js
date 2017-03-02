module.exports = {
    parseSideResult: function (value) {
        if (typeof value === "number") {
            this.success = true;
            this.side = value;
        } else {
            this.success = false;
            this.errorMessage = value;
        }
    },
    matrixResult: function (matrix, sum, side, success) {
        this.matrix = matrix;
        this.sum = sum;
        this.side = side;
        this.success = success;
    }
}