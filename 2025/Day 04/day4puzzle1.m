%% day4puzzle1 - Daniel Breslan - Advent Of Code 2025
map = char(readlines("input.txt")) == '@';
day4puzzle1result = nnz(map & (conv2(map,ones(3),"same") .* map < 5))