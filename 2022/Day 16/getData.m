function [vlu,dlu,allVals] = getData(fn)
data = readlines(fn).erase(["Valve ","has flow rate=", ...
    "; tunnels lead to valves" "; tunnel leads to valve" ","]);
g = digraph;
g = addnode(g,data.extractBefore(3));
for idx = 1:numel(data)
    prts = data(idx).split(" ");
    newEdge = prts(3:end);
    g = addedge(g,prts(1), newEdge);
end
vlu = dictionary(["AA"; data(data.extractBetween(3, 5).double() ~= 0) ...
    .extractBefore(3)], [0; data(data.extractBetween(3, 5) ...
    .double() ~= 0).extractBetween(3, 5).double()]);
allVals = ["AA"; data(data.extractBetween(3, 5).double() ~= 0)...
    .extractBefore(3)];

dist = zeros(numel(allVals),numel(allVals));
for r = 1:numel(allVals)
    for c = 1:numel(allVals)
        if r == c
            continue
        end
        dist(r,c) = numel(shortestpath(g, allVals(r),allVals(c))) - 1;
    end
end

allLoc = allVals + allVals';
allLoc = allLoc(:);

dlu = dictionary(allLoc,dist(:));
end

