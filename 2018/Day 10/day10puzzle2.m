%% day10puzzle2 - Daniel Breslan - Advent Of Code 2018
data = readlines("input.txt").erase(["position=<"," velocity="," ",">"])...
    .replace("<",",").split(",").double();

idx = 0;

while true
    newdata = advance(data);
    if max(newdata(:,1)) > max(data(:,1)) 
        break
    else
        data = newdata;
        idx = idx + 1;
    end
end
day10puzzle1result = idx %#ok<NOPTS> 