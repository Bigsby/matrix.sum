use crate::results;

struct CurrentHolder {
    row: i32,
    column: i32,
    start_row: i32,
    start_column: i32,
    side: i32,
}

impl CurrentHolder {
    fn new(row: i32, column: i32, side: i32) -> CurrentHolder {
        return CurrentHolder {
            row,
            column,
            start_row: row,
            start_column: column,
            side,
        };
    }

    fn actual(&self, value: i32) -> usize {
        return match value {
            v if v < 0 => (v + self.side) as usize,
            v if v >= self.side => (v - self.side) as usize,
            _ => value as usize,
        };
    }

    fn actual_row(&self) -> usize {
        return self.actual(self.row);
    }

    fn actual_column(&self) -> usize {
        return self.actual(self.column);
    }

    fn next(&mut self, count: i32) {
        if count % self.side != 0 {
            self.row += 1;
            self.column += 1;
        } else {
            self.start_row += 1;
            self.row = self.start_row;
            self.start_column -= 1;
            self.column = self.start_column;
        }
    }
}

fn create_empty_matrix(side: i32) -> Vec<Vec<i32>> {
    let mut result = vec![];
    for _ in 0..side {
        result.push(vec![0; side as usize]);
    }
    return result;
}

fn test_result(matrix: &Vec<Vec<i32>>, expected_sum: i32, side: usize) -> bool {
    let mut sum;
    for row_index in 0..side {
        sum = 0;
        for column_index in 0..side {
            sum += matrix[row_index][column_index];
        }
        if sum != expected_sum {
            return false;
        }
    }

    for column_index in 0..side {
        sum = 0;
        for row_index in 0..side {
            sum += matrix[row_index][column_index];
        }
        if sum != expected_sum {
            return false;
        }
    }

    sum = 0;
    for diagonal_index in 0..side {
        sum += matrix[diagonal_index][diagonal_index];
    }
    return sum == expected_sum;
}

pub fn calculate(side: i32) -> results::MatrixResult {
    if side % 2 != 1 {
        return Err("Side needs to be an odd number.".to_owned());
    }

    let expected_sum = side * (side * side + 1) / 2;
    let mut matrix = create_empty_matrix(side);
    let mut current = CurrentHolder::new(-(side - 1) / 2, side / 2, side);

    for count in 1..=(side * side) {
        matrix[current.actual_row()][current.actual_column()] = count;
        current.next(count);
    }
    if test_result(&matrix, expected_sum, side as usize) {
        return Ok(results::MatrixData {
            matrix,
            sum: expected_sum,
            side: side as usize,
        });
    }

    return Err("Calculation error.".to_owned());
}
