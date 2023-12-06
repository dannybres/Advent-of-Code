%% day6puzzle2 - Daniel Breslan - Advent Of Code 2023
data = readlines("input.txt").extract(digitsPattern).join("").double();
day6puzzle2result = sum((0:data(1,idx)) .* (data(1,idx) - (0:data(1,idx))) > data(2,idx)) %#ok<NOPTS> 