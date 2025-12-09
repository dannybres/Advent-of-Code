%% day9puzzle1 - Daniel Breslan - Advent Of Code 2025
data = readlines("input.txt").split(",").double;
format longg
day9puzzle1result = max(abs(data(:,1) - data(:,1)' + 1) .* abs(data(:,2) - data(:,2)' + 1),[],"all")
