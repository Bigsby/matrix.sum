local consoleUtil = require("consoleUtil")
local calculator = require("matrixCalculator")

local function errorOut(message)
	print(message)
	os.exit(1)
end

local function handleInput(input)
	local side = tonumber(input)
	if side == nil then
		errorOut("Side input not valid!")
	end
	consoleUtil.displayMatrixResult(calculator.calculate(side))
end

local function main()
	if #arg == 1 then
		handleInput(arg[1])
	else
		handleInput(consoleUtil.prompt("Input side:"))
	end
end

main()
