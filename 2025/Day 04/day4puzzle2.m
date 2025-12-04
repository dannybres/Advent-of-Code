%% day4puzzle2 - Daniel Breslan - Advent Of Code 2025
map = char(readlines("input.txt")) == '@';
cn = ones(3); cn(2,2) = 0;

day4puzzle1result = 0;
canRemove = 1;
while nnz(canRemove)
    numAdj = conv2(map,cn,"same");
    numAdj(~map) = inf;
    canRemove = numAdj .* map < 4;
    day4puzzle1result = day4puzzle1result + nnz(canRemove);
    map(canRemove) = 0;
end
day4puzzle1result
