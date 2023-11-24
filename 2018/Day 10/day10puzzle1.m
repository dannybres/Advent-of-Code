%% day10puzzle1 - Daniel Breslan - Advent Of Code 2018
data = readlines("input.txt").erase(["position=<"," velocity="," ",">"])...
    .replace("<",",").split(",").double();

while true
    newdata = advance(data);
    if max(newdata(:,1)) > max(data(:,1)) 
        break
    else
        data = newdata;
    end
end
day10puzzle1result = visualise(data) %#ok<NOPTS> 