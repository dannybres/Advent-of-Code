%% day6puzzle1 - Daniel Breslan - Advent Of Code 2024
initialMap = char(readlines("input.txt"));
[r0,c0] = find(initialMap ~= '.' & initialMap ~= '#');
l0 = [r0,c0];
clc
[visited,loop] = walk(l0, initialMap);
day6puzzle1result = nnz(any(visited,3))

day6puzzle2result = 0;
[r,c] = find(any(visited,3));
for idx = 1:numel(r)
    newMap = initialMap;
    newMap(r(idx),c(idx)) = '#';
    [visited,loop] = walk(l0, newMap);
    if loop
        day6puzzle2result = day6puzzle2result + 1;
    end
end
day6puzzle2result

function [visited,loop] = walk(guard, map)
loop = false;
dirs = [-1 0
    0 1
    1 0
    0 -1];
di = 1;
visited = false([size(map),4]);
visited(guard(1),guard(2),di) = true;
while true
    cl = guard + dirs(di,:);
    if any(cl<1) || any(cl > height(map))
        break
    end
    if map(cl(1),cl(2)) ~= '#'
        guard = cl;
    else
        di = di + 1;
        if di == 5
            di = 1;
        end
    end
    if visited(guard(1),guard(2),di)
        loop = true;
        break
    end
    visited(guard(1),guard(2),di) = true;
end
end