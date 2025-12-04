%% day4puzzle1 - Daniel Breslan - Advent Of Code 2025
map = char(readlines("input.txt")) == '@';
numAdj = conv2(map,ones(3),"same");
numAdj(~map) = inf;
day4puzzle1result = nnz(numAdj .* map < 5)