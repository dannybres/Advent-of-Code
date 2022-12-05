%% day10puzzle1 - Daniel Breslan - Advent Of Code 2020
data = readmatrix("input.txt");
prod(sum(diff(sort([0; data; max(data) + 3])) == [1 3]))