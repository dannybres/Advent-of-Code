map = char(readlines("input.txt"));
clc
map(map == '<' | map == '>' | map == 'v' | map == '^') = '.';
mc = zeros(3);
mc(2:2:end) = 1;
con = conv2(map == '.',mc,"same");
[r,c] = find(con > 2 & map == '.');
[jidx] = find(con > 2 & map == '.');
startPt = [1 find(map(1,:) == '.')];
endPt = [size(map,1),find(map(end,:) == '.')];

j = [startPt 1;[r c con(jidx)];endPt 1];

g = graph();
g = addnode(g,"r" + j(:,1) + "c" + j(:,2));


for idx = 1:size(j,1)
    junction = j(idx,:);
    pathStarts = junction(1:2) + [0 1;1 0;-1 0;0 -1];
    pathStarts = pathStarts(~(any(pathStarts < 1,2) | any(pathStarts > size(map,1),2)),:);
    pathStarts = pathStarts(map(sub2ind(size(map),pathStarts(:,1),pathStarts(:,2))) == '.',:);
    for psi = 1:size(pathStarts,1)
        [x,y,n] = dfs(map,pathStarts(psi,1),pathStarts(psi,2),junction(1),junction(2),1);
        g = g.addedge(compose("r%ic%i",junction(1),junction(2)),compose("r%ic%i",x,y), ...
            n);
    end
end
close all
plot(g,EdgeLabel=g.Edges.Weight)

[~,e] = g.allpaths(compose("r%ic%i",startPt(1),startPt(2)),compose("r%ic%i",endPt(1),endPt(2)));
numel(e)
max(cellfun(@(x) sum(g.Edges.Weight(x)),e))

function [x,y,n] = dfs(map,x,y,fx,fy,n)
% disp(compose("%i,%i from %i,%i, with %i",x,y,fx,fy,n))
step = [x y] + [0 1;1 0;-1 0;0 -1];
step(ismember(step,[fx,fy],"rows"),:) = [];
step = step(~(any(step < 1,2) | any(step > size(map,1),2)),:);
step = step(map(sub2ind(size(map),step(:,1),step(:,2))) == '.',:);
if size(step,1) == 1
    [x,y,n] = dfs(map,step(1),step(2),x,y,n+1);
else
    if size(step,1) == 0
        disp(compose("no steps for [%i,%i]",x,y))
    end
    return
end
end