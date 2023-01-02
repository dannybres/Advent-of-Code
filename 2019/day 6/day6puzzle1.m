%% day6puzzle1 - Daniel Breslan - Advent Of Code 2019
EdgeTable = table(readlines("input.txt").split(")"),...
    'VariableNames',{'EndNodes'});
d = graph(EdgeTable);
day6puzzle1result = 0;

for planet = string(d.Nodes.Variables)'
    day6puzzle1result = day6puzzle1result + ...
        numel(shortestpath(d,"COM",planet))-1;
end

day6puzzle1result %#ok<NOPTS> 