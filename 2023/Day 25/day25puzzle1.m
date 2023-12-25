%% day25puzzle1 - Daniel Breslan - Advent Of Code 2023
data = readlines("input.txt");
d = graph;
for idx = 1:numel(data) % buold graph
    node = data(idx).extractBefore(":");
    for to = data(idx).extractAfter(": ").split(" ")'
        d = addedge(d,node,to);
    end
end

t = zeros(d.numedges,1); % sample some and find common paths
nodes = string(d.Nodes.Name);
for idx = 1:1e3
    from = nodes(randi(d.numnodes));
    to = nodes(randi(d.numnodes));
    [~,~,path] = shortestpath(d,from,to);
    t(path) = t(path) + 1;
end

%remove 3 most used and calc
rem = d.Edges.EndNodes(any(maxk(t,3) == t'),:);
for idx = 1:size(rem,1)
    rr = rem(idx,:);
    d = rmedge(d,rr{1},rr{2});
end
c = conncomp(d);
day25puzzle1result = sum(c==1)*sum(c==2) %#ok<NOPTS>