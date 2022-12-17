%% day16puzzle2 - Daniel Breslan - Advent Of Code 2022
[vlu,dlu,allVals] = getData("input.txt");

indices = dictionary(allVals,0:numel(allVals)-1);

global cache
cache = dictionary(string.empty,double.empty);

b = bitshift(1,numel(allVals))-1;
day16puzzle2result = 0;

for idx = 0:floor(b/2)
    if mod(idx,1e2) == 0
        disp(idx)
    end
    day16puzzle2result = max(day16puzzle2result,...
        dfs(26, "AA", idx, dlu, vlu, indices) + ...
        dfs(26, "AA", b-idx, dlu, vlu, indices));
end
day16puzzle2result

function maxval = dfs(time, valve, bitmask, dlu, vlu, indices)
global cache
if isKey(cache,time + valve + bitmask)
    maxval = cache(time + valve + bitmask);
    return
end
maxval = 0;
for neighbour = dlu(valve).keys'
    bit = bitshift(1,indices(neighbour));
    if bitand(bit,bitmask)
        continue
    end
    dForV = dlu(valve);
    remtime = time - dForV(neighbour) - 1;
    if remtime <= 0
        continue
    end
    mmm = dfs(remtime, neighbour, bitor(bitmask,bit),...
        dlu, vlu, indices);
    maxval = max(maxval, mmm + vlu(neighbour) * remtime);
    cache(time + valve + bitmask) = maxval;
end
end