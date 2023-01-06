%% day2puzzle1 - Daniel Breslan - Advent Of Code 2019
addpath("../intCodeComputer/")
data = readlines("input.txt").split(",").double();
data(2:3) = [12 2];
[~, data] = processIntCodeComputer(data); 

day2puzzle1result = data(0) %#ok<NOPTS> 