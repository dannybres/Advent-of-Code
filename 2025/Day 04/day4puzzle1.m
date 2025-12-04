%% day4puzzle1 - Daniel Breslan - Advent Of Code 2025
map = char(readlines("input.txt")) == '@';
cn = ones(3); cn(2,2) = 0;
numAdj = conv2(map,cn,"same");
numAdj(~map) = inf;
day4puzzle1result = nnz(numAdj .* map < 4)
