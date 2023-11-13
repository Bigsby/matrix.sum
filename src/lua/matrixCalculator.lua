local module = {}

local CurrentHolder = {
	row = 0,
	startRow = 0,
	column = 0,
	startColumn = 0,
	side = 0,
}

function CurrentHolder:new(row, column, side)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	self.row = row
	self.startRow = row
	self.column = column
	self.startColumn = column
	self.side = side
	return o
end

function CurrentHolder:next(count)
	if count % self.side ~= 0 then
		self.row = self.row + 1
		self.column = self.column + 1
	else
		self.startRow = self.startRow + 1
		self.row = self.startRow
		self.startColumn = self.startColumn - 1
		self.column = self.startColumn
	end
end

function CurrentHolder:actual(value)
	if value < 0 then
		return value + self.side + 1
	end
	if value >= self.side then
		return value - self.side + 1
	end
	return value + 1
end

function CurrentHolder:actualRow()
	return self:actual(self.row)
end

function CurrentHolder:actualColumn()
	return self:actual(self.column)
end

local function createEmtpyMatrix(side)
	local matrix = {}
	for rowIndex = 1, side do
		local row = {}
		for columnIndex = 1, side do
			row[columnIndex] = 0
		end
		matrix[rowIndex] = row
	end
	return matrix
end

local function testResult(matrix, expectedSum, side)
	local sum = 0
	for rowIndex = 1, side do
		sum = 0
		for columnIndex = 1, side do
			sum = sum + matrix[rowIndex][columnIndex]
		end
		if sum ~= expectedSum then
			return false
		end
	end

	for columnIndex = 1, side do
		sum = 0
		for rowIndex = 1, side do
			sum = sum + matrix[rowIndex][columnIndex]
		end
		if sum ~= expectedSum then
			return false
		end
	end

	sum = 0
	for diagonalIndex = 1, side do
		sum = sum + matrix[diagonalIndex][diagonalIndex]
	end
	return sum == expectedSum
end

function module.calculate(side)
	if side % 2 ~= 1 then
		error("Side needs to be an odd number.")
	end

	local expectedSum = math.floor(side * (side * side + 1) / 2)
	local matrix = createEmtpyMatrix(side)
	local current = CurrentHolder:new(-math.floor((side - 1) / 2), math.floor(side / 2), side)
	for count = 1, side * side do
		local actualRow = current:actualRow()
		local actualColumn = current:actualColumn()
		matrix[actualRow][actualColumn] = count
		current:next(count)
	end
	return {
		matrix = matrix,
		sum = expectedSum,
		side = side,
		success = testResult(matrix, expectedSum, side),
	}
end

return module
