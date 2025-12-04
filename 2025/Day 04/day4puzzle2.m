%% day4puzzle2 - Daniel Breslan - Advent Of Code 2025
map = char(readlines("input.txt")) == '@';

initialCount = nnz(map);
while true
    canRemove = map & (conv2(map,ones(3),"same") .* map < 5);
    map(canRemove) = false;
    if ~nnz(canRemove), break, end
end
day4puzzle1result = initialCount - nnz(map)
