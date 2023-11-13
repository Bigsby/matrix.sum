local module = {}

function module.prompt(question)
	print(question)
	return io.read()
end

function module.displayMatrixResult(matrixResult)
	local matrix = matrixResult.matrix
	local side = #matrix
	local length = math.max(#tostring(side * side) + 1, 2)
	for row = 1, side do
		for column = 1, side do
			io.write(string.format("%" .. length .. "d", matrix[row][column]))
		end
		print()
	end
	print("Sum: " .. matrixResult.sum)
end

return module
