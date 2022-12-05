%% day12puzzle1 - Daniel Breslan - Advent Of Code 2021
data = readlines("input.txt").split("-");

g = graph;
g = addedge(g,data(:,1),data(:,2));

allPaths = {};
thisPath = strings(0);
visited = false(1, numnodes(g));
allPaths = processMe(g,"start","end",allPaths,visited,thisPath);
numel(allPaths)

function [allPaths] = processMe(g,st,en,allPaths,visited,thisPath)
visited(findnode(g,st)) = true;
neighb = neighbors(g,st);
thisPath(end+1) = st;

if st == en
    allPaths{end+1} = thisPath;
else
    for idx = 1:numel(neighb)
        if (~visited(findnode(g,neighb(idx))) || all(isstrprop(neighb(idx),"upper")))
            allPaths = processMe(g,neighb(idx),en,allPaths,visited,thisPath);
        end
    end
end
end