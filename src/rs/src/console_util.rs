use std::cmp;

use crate::results;

pub fn prompt(question: &str) -> String {
    println!("{}", question);
    let mut input = String::new();
    std::io::stdin().read_line(&mut input).unwrap();
    return input;
}

pub fn display_matrix_result(result: results::MatrixData) -> () {
    let matrix = result.matrix;
    let side = result.side;
    let length = cmp::max((side * side).to_string().len() + 1, 2);
    for row_index in 0..side {
        for column_index in 0..side {
            print!("{:1$}", matrix[row_index][column_index], length);
        }
        println!();
    }
    println!("Sum: {}", result.sum);
}
