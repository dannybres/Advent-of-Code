%% day5puzzle2 - Daniel Breslan - Advent Of Code 2019
% Instruction(instriction pointer) > opcode and 3 parameter
data = readlines("input.txt").split(",").double();
input = 5;

day2puzzle1result = runIntcode(data,input)