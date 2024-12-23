%% day23puzzle2 - Daniel Breslan - Advent Of Code 2024
data = readlines("input.txt").split("-");
nodes = unique(data(:));
party = [];

neighbors = configureDictionary("string","string");
for idx = 1:numel(nodes)
    neighbors(nodes(idx)) = neighboursOf(nodes(idx),data).join(",");
end


for nidx = 1:height(data)
    newNeighbour = check(data(nidx,:),data,neighbors);
    if numel(newNeighbour) + 2 > numel(party)
        party = [data(nidx,:) newNeighbour];
    end
end
day23puzzle2result = sort(party).join(",")


function newNodes = check(nodes,data,neighbors)
for idx = 1:numel(nodes)
    nn = neighbors(nodes(idx)).split(",");
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
    conn(ridx,:) = any(neighbors(node).split(",") == newNodes);
    conn(ridx,ridx) = true;
end
if max(sum(conn)) == 1
    newNodes = [];
else
    newNodes = newNodes(sum(conn) == max(sum(conn)));
end
end


function neighbours = neighboursOf(node,data)
neighbours = data(any(node == data,2),:);
neighbours = neighbours(:);
neighbours(neighbours == node) = [];
end