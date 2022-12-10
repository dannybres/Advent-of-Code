%% day10puzzle1 - Daniel Breslan - Advent Of Code 2022
data = readlines("input.txt").replace(["noop" "addx "],["1 0" "2 "])...
    .split(" ").double();
data(:,1) = cumsum(data(:,1));

idx = [20 60 100 140 180 220]';

day10puzzle1result = sum((sum((repmat(data(:,1)',numel(idx),1) < idx) .*...
    repmat(data(:,2)',numel(idx),1),2) + 1) .* idx) %#ok<NOPTS> 
