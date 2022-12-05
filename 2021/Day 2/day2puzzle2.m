inputData = readtable("input.txt",TextType="string");

inputData.Properties.VariableNames = ["Direction","Amount"];

horizontalPosition = sum(inputData.Amount(inputData.Direction == "forward"));
justDown = inputData.Amount.*(inputData.Direction == "down");
justUp = inputData.Amount.*(inputData.Direction == "up");
aim = cumsum(justDown - justUp);
depth = sum(inputData.Amount(inputData.Direction == "forward") .* ...
    aim(inputData.Direction == "forward"));

format long g
day2puzzle2Result = horizontalPosition * depth
format short