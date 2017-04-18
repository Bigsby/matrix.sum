export class ParseSideResult {
    private constructor(
        public success: boolean,
        public side: number,
        public errorMessage: string) {
    }

    static Successful(side: number): ParseSideResult {
        return new ParseSideResult(true, side, null);
    }

    static Failure(errorMessage: string): ParseSideResult {
        return new ParseSideResult(false, 0, errorMessage);
    }
}

export class MatrixResult {
    constructor(
        public matrix: number[][],
        public sum: number,
        public side: number,
        public success: boolean
    ) { }
}