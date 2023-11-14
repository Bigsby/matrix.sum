pub type ParseResult = std::result::Result<i32, String>;

pub type MatrixResult = std::result::Result<MatrixData, String>;

pub struct MatrixData {
    pub matrix: Vec<Vec<i32>>,
    pub sum: i32,
    pub side: usize,
}
