%% day9puzzle2 - Daniel Breslan - Advent Of Code 2019
addpath('../day 5/')
data = readlines("input.txt").split(",").double();

day9puzzle2result = runIntcode(data, 2)
