%% day9puzzle1 - Daniel Breslan - Advent Of Code 2019
addpath('../day 5/')
data = readlines("input.txt").split(",").double();

runIntcode(data, 1)

% 203 is too low

day9puzzle1result = 0;