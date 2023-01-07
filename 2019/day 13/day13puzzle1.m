%% day13puzzle1 - Daniel Breslan - Advent Of Code 2019
addpath("../intCodeComputer/")
data = readlines("input.txt").split(",").double();
output = processIntCodeComputer(data);
day13puzzle2result = sum(output(3:3:end) == 2) %#ok<NOPTS> 
