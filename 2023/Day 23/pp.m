map = char(readlines("input.txt"));

startPt = [1 find(map(1,:) == '.')];
endPt = [size(map,1),find(map(end,:) == '.')];
mc = zeros(3); mc(2:2:end) = 1;
con = conv2(map ~= '#',mc,"same");
[r,c] = find(con > 2 & map == '.');

junctions = [startPt;endPt;[r c]];

s = struct;

for idx = 1:size(junctions,1)
    junction = junctions(idx,:);
    pathStarts = junction(1:2) + [0 1;1 0;-1 0;0 -1];
    pathStarts = pathStarts(~(any(pathStarts < 1,2) |...
        any(pathStarts > size(map,1),2)),:);
    pathStarts = pathStarts(...
        map(sub2ind(size(map),pathStarts(:,1),pathStarts(:,2))) ~= '#',:);
    for psi = 1:size(pathStarts,1)
        [x,y,n] = dfsCompress(map,pathStarts(psi,1),pathStarts(psi,2), ...
            junction(1),junction(2),1);
        s.(compose("r%ic%i",junction(1),junction(2)) ...
            ).(compose("r%ic%i",x,y)) = n;
    end
end
s

longHike(compose("r%ic%i",junctions(1),junctions(1,2)),s,"z", ...
    compose("r%ic%i",junctions(2,1),junctions(2,2)))

function m = longHike(junction,graph,seen,target)
    if junction == target
        m = 0;
        return
    end
    m = -Inf;
    for next = string(fieldnames(graph.(junction)))'
        if all(next ~= seen)
            m = max(m,longHike(next,graph,[seen;junction],target) + ...
                graph.(junction).(next));
        end
    end
end


function [x,y,n] = dfsCompress(map,x,y,fx,fy,n)
step = [x y] + [0 1;1 0;-1 0;0 -1];
step(ismember(step,[fx,fy],"rows"),:) = [];
step = step(~(any(step < 1,2) | any(step > size(map,1),2)),:);
step = step(map(sub2ind(size(map),step(:,1),step(:,2))) ~= '#',:);
if size(step,1) == 1
    [x,y,n] = dfsCompress(map,step(1),step(2),x,y,n+1);
end
end