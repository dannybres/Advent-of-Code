%% day10puzzle1 - Daniel Breslan - Advent Of Code 2020
data = readmatrix("input.txt");

q = diff(sort([0; data; max(data) + 3])) == [1 2 3];
e = bwconncomp(q(:,1));
r = prod([2 4 7].^sum(cellfun(@numel,e.PixelIdxList)' == [2 3 4]))