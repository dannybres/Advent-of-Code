%% day6puzzle1 - Daniel Breslan - Advent Of Code 2023
data = readlines("input.txt").extract(digitsPattern).double();
res = 1;
for idx = 1:size(data,2)
    res = prod([res, sum((0:data(1,idx)) .* (data(1,idx) ...
        - (0:data(1,idx))) > data(2,idx))]);
end
day6puzzle1result = res %#ok<NOPTS> 