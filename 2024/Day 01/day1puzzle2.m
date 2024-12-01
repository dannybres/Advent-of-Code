%% day1puzzle2 - Daniel Breslan - Advent Of Code 2024
data = double(readlines("input.txt").extract(digitsPattern));
day1puzzle2result = sum(d1 .* sum(data(:,1) == data(:,2)',2))