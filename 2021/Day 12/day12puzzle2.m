%% day12puzzle2 - Daniel Breslan - Advent Of Code 2021
data = readlines("input.txt").split("-");

g = graph;
g = addedge(g,data(:,1),data(:,2));

allPaths = {};
thisPath = strings(0);
visited = zeros(1, numnodes(g));
allPaths = processMe(g,"start","end",allPaths,visited,thisPath);

% string(cellfun(@join,allPaths))'
numel(allPaths)

function [allPaths] = processMe(g,st,en,allPaths,visited,thisPath)
visited(findnode(g,st)) = visited(findnode(g,st)) + 1;
neighb = neighbors(g,st);
neighb(neighb == "start") = [];
thisPath(end+1) = st;

if st == en
    allPaths{end+1} = thisPath;
else
    for idx = 1:numel(neighb)
        if (~visited(findnode(g,neighb(idx))) || ... % not visited
                (all(isstrprop(neighb(idx),"upper")) || ~any(visited(cellfun(@all,isstrprop(string(table2cell(g.Nodes))','lower'))) > 1)))

            [allPaths] = processMe(g,neighb(idx),en,allPaths,visited,thisPath);
        end
    end
end
end
