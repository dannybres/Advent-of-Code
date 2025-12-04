%% day4puzzle2 - Daniel Breslan - Advent Of Code 2025
map = char(readlines("input.txt")) == '@';

day4puzzle1result = 0;
canRemove = 1;
while nnz(canRemove)
    numAdj = conv2(map,ones(3),"same");
    numAdj(~map) = inf;
    canRemove = numAdj .* map < 5;
    day4puzzle1result = day4puzzle1result + nnz(canRemove);
    map(canRemove) = 0;
end
day4puzzle1result
