%% day9puzzle1 - Daniel Breslan - Advent Of Code 2019
addpath('../day 5/')
data = readlines("input.txt").split(",").double();

day9puzzle1result = runIntcode(data, 1)