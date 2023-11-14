use std::env;

mod console_util;
mod matrix_calculator;
mod results;

fn parse_input(input: &str) -> results::ParseResult {
    match input.trim().parse::<i32>() {
        Ok(value) => Ok(value),
        Err(_) => Err("Input not valid".to_owned()),
    }
}

fn error_out(message: &str) -> () {
    println!("{}", message);
    std::process::exit(1);
}

fn main() {
    let input = match env::args().len() {
        1 => console_util::prompt("Input side: "),
        2 => env::args().last().unwrap(),
        _ => "Too many arguments.".to_string(),
    };
    let parse_result = parse_input(&input);
    match parse_result {
        Err(message) => error_out(&message),
        Ok(side) => match matrix_calculator::calculate(side) {
            Err(message) => error_out(&message),
            Ok(result) => console_util::display_matrix_result(result),
        },
    }
}
