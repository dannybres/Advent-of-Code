%% day21puzzle1 - Daniel Breslan - Advent Of Code 2023
clc
map = char(readlines("input.txt"));
[rr, rc] = find(map == '#');
r = [rr rc];
[gr,gc] = find(map == 'S');
g = [gr gc];

for idx = 1:64
    g = pagetranspose(g + reshape([0 1 1 0 -1 0 0 -1],1,2,4));
    g = reshape(g,2,[],1)';
    g = unique(g,"rows");
    g = g(~ismember(g,r,"rows"),:);
end
day21puzzle1result = height(g)
