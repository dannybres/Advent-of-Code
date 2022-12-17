%% day16puzzle1 - Daniel Breslan - Advent Of Code 2022
tic
[vlu,dlu,allVals] = getData("input.txt");

indices = dictionary(allVals,1:numel(allVals));

cache = dictionary(string.empty,double.empty);
day16puzzle1result = dfs(30, "AA", 0, dlu, vlu, indices, cache);

maxVal
toc

function [maxval, cache] = dfs(time, valve, bitmask, dlu, vlu, indices, cache)
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
        [mmm, cache] = dfs(remtime, neighbour, bitor(bitmask,bit),...
            dlu, vlu, indices, cache);
        maxval = max(maxval, mmm + vlu(neighbour) * remtime);
        cache(time + valve + bitmask) = maxval;
    end
end