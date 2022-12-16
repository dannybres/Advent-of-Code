%% day16puzzle1 - Daniel Breslan - Advent Of Code 2022
close all
data = readlines("input.txt").erase(["Valve ","has flow rate=", ...
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

paths = [repelem(allVals(1),numel(allVals),1) allVals];
t = dlu(paths(:,end-1) + paths(:,end)) + 1; % open
pres = (30 - t) .* vlu(paths(:,end));

keep =  false(size(paths,1),1);
    for iidx = 1:size(paths,1)
        if(numel(unique(paths(iidx,:))) == size(paths,2))
            keep(iidx) = true;
        end
    end
    paths = paths(keep,:);
    t = t(keep,:);
    pres = pres(keep,:);
maxSoFar = 0;
while 1
    newEle = repmat(allVals,numel(t),1);
    paths = repelem(paths,numel(allVals),1);
    paths = [paths newEle];
    t = repelem(t,numel(allVals),1);
    pres = repelem(pres,numel(allVals),1);
    t = t + dlu(paths(:,end-1) + paths(:,end)) + 1;
    pres = pres + (30 - t) .* vlu(paths(:,end));
    keep =  false(size(paths,1),1);
    for iidx = 1:size(paths,1)
        if(numel(unique(paths(iidx,:))) == size(paths,2))
            keep(iidx) = true;
        end
    end
    paths = paths(keep,:);
    t = t(keep,:);
    pres = pres(keep,:);
    paths = paths(t<30,:);
    pres = pres(t<30,:);
    t = t(t<30,:);
    mmm = pres(pres == max(pres) & t <=30);
    if isempty(mmm)
        break
    else
        maxSoFar = max(maxSoFar, mmm);
    end
end
maxSoFar %#ok<NOPTS> 
