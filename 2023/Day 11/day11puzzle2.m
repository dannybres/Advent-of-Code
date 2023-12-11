%% day11puzzle2 - Daniel Breslan - Advent Of Code 2023
data = char(readlines("input.txt"));
[r,c] = ind2sub(size(data),find(data == '#'));
blanks = data == '.';
cs = cumsum(ones(1,size(data,1)) + all(blanks)*(1e6-1));
rs = cumsum(ones(size(data,2),1) + all(blanks,2)*(1e6-1));
r = rs(r);
c = cs(c)';
day11puzzle2result = (sum(abs(c - c') + abs(r - r'),"all"))/2 %#ok<NOPTS>