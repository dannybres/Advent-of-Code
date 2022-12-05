%% day7puzzle1 - Daniel Breslan - Advent Of Code 2021
data = readmatrix('input.txt');
day7puzzle1result = sum(abs(data-median(data)))