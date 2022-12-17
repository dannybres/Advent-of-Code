function [vlu,dlu,allVals] = getData(fn)
data = readlines(fn).erase(["Valve ","has flow rate=", ...
    "; tunnels lead to valves" "; tunnel leads to valve" ","]);

%% All valves
allVals = ["AA"; data(data.extractBetween(3, 5).double() ~= 0)...
    .extractBefore(3)];

%% Valve Magnitude
vlu = dictionary(data(data.extractBetween(3, 5).double() ~= 0) ...
    .extractBefore(3), data(data.extractBetween(3, 5) ...
    .double() ~= 0).extractBetween(3, 5).double());
%% Distance from Any to Any
g = digraph;
g = addnode(g,data.extractBefore(3));
for idx = 1:numel(data)
    prts = data(idx).split(" ");
    newEdge = prts(3:end);
    g = addedge(g,prts(1), newEdge);
end

%% distance between all points
dist = zeros(numel(allVals),numel(allVals));
for r = 1:numel(allVals)
    for c = 1:numel(allVals)
        if r == c
            continue
        end
        dist(r,c) = numel(shortestpath(g, allVals(r),allVals(c))) - 1;
    end
end

allDist = dictionary();
for idx = 1:size(dist(:,1))
    distances = dist(idx,:)';
    vals = allVals(distances ~= 0)';
    distances = distances(distances ~= 0)';
    distances = distances(vals ~= "AA");
    vals = vals(vals ~= "AA");
    allDist(allVals(idx)) = dictionary(vals, distances);
end
dlu = allDist;


allVals = allVals(2:end)';