%% day15puzzle1 - Daniel Breslan - Advent Of Code 2021
data = readlines("input.txt").split("");
data = data(:,2:end-1).double();
locations = reshape(1:numel(data),size(data));
offsets = [1 0; -1 0; 0 1; 0 -1];

g = digraph;
for r = 1:size(data,1)
    for c = 1:size(data,2)
        for os = offsets'
            if r + os(1) < 1 || c + os(2) < 1 || r + os(1) > size(data,1) || c + os(2) > size(data,2)
                continue
            end
            g = addedge(g,locations(r,c), locations(r+os(1),c+os(2)),data(r+os(1),c+os(2)));
        end
    end
end
[~,day15puzzle1result] = shortestpath(g,locations(1,1),locations(end,end))


