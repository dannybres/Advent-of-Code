%% day1puzzle1 - Daniel Breslan - Advent Of Code 2024
data = double(readlines("input.txt").extract(digitsPattern));
day1puzzle1result = sum(abs(sort(data(:,1)) - sort(data(:,2))));