%% day15puzzle1 - Daniel Breslan - Advent Of Code 2021
data = readlines("input.txt").split("");
data = data(:,2:end-1).double();
data = mod(repmat(data,5,5) + repelem((0:4) + (0:4)',size(data,1),size(data,2)),9);
data(data == 0) = 9;
locations = reshape(1:numel(data),size(data));

g = digraph;
r = 2:size(data,1)-1;
g = addedge(g,[locations(r,:) locations(r,:) locations(:,r)' locations(:,r)'], ...
    [locations(r-1,:) locations(r+1,:) locations(:,r-1)' locations(:,r+1)'], ...
    [data(r-1,:) data(r+1,:) data(:,r-1)' data(:,r+1)']);

g = addedge(g,locations(1,:), locations(2,:),data(2,:));
g = addedge(g,locations(:,1), locations(:,2),data(:,2));

g = addedge(g,locations(end,:), locations(end-1,:),data(end-1,:));
g = addedge(g,locations(:,end), locations(:,end-1),data(:,end-1));

[~,day15puzzle1result] = shortestpath(g,locations(1,1),locations(end,end))
