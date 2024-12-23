%% day23puzzle2 - Daniel Breslan - Advent Of Code 2024
profile on
data = readlines("input.txt").split("-");
nodes = unique(data(:));
party = [];
for nidx = 1:height(data)
    newNeighbour = check(data(nidx,:),data);
    if numel(newNeighbour) + 2 > numel(party)
        party = [data(nidx,:) newNeighbour];
    end
end
day23puzzle2result = sort(party).join(",")
profile viewer



function newNodes = check(nodes,data)
for idx = 1:numel(nodes)
    nn = neighboursOf(nodes(idx),data);
    nn(ismember(nn,nodes)) = [];
    if exist("newNodes","var")
        newNodes = nn(ismember(nn,newNodes));
    else
        newNodes = nn;
    end
end
newNodes = reshape(newNodes,1,[]);
if isempty(newNodes), return, end
conn = false(numel(newNodes),numel(newNodes));
for ridx = 1:numel(newNodes)
    node = newNodes(ridx);
    conn(ridx,:) = any(neighboursOf(node,data) == newNodes);
    conn(ridx,ridx) = true;
end
if max(sum(conn)) == 1
    newNodes = [];
else
    newNodes = newNodes(sum(conn) == max(sum(conn)));
end

end


g = graph;
g = g.addedge(data(:,1),data(:,2));
plot(g)
function neighbours = neighboursOf(node,data)
neighbours = data(any(node == data,2),:);
neighbours = neighbours(:);
neighbours(neighbours == node) = [];
end