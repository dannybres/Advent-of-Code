%% day7puzzle1 - Daniel Breslan - Advent Of Code 2018
data = readlines("input.txt")...
    .split(" must be finished before step ")...
    .erase(["Step "," can begin."]);
d = digraph(table(data,'VariableNames',{'EndNodes'}));

pathTaken = "";
while d.numnodes > 0
    unVisitedNodes = string(d.Nodes.Name);
    nodeWithIn = unique(string(d.Edges.EndNodes(:,2)));

    availableNodes = sort(unVisitedNodes(...
        ~any(unVisitedNodes == nodeWithIn',2)));

    pathTaken = pathTaken + availableNodes(1);

    d = d.rmnode(availableNodes(1));
end
day7puzzle1result = pathTaken %#ok<NOPTS> 
