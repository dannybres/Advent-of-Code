%% day12puzzle1 - Daniel Breslan - Advent Of Code 2022
data = char(readlines("input.txt"));

[startR,startC] = find(data == 'S');            % find start point
data(startR,startC) = 'a';                      % fix start point
[bestSignalR,bestSignalC] = find(data == 'E');  % find best signal
data(bestSignalR,bestSignalC) = 'z';            % fix best signal

data = double(data) - double('a') + 1;          % a-z to 1-26

d = digraph;                                    % Make digraph

n = "Tree" + (1:size(data,1)) + "_" + (1:size(data,2))'; % list all nodes
d = addnode(d,n(:));                            % add nodes

for r = 1:size(data,1)
    for c = 1:size(data,2)
        mover = [0 1; 1 0; 0 -1; -1 0];
        opts = [r c] + mover;
        opts = opts(~any(opts < 1,2),:); % remove off the left & top
        opts = opts(~(opts(:,1) > size(data,1)),:); % remove off right
        opts = opts(~(opts(:,2) > size(data,2)),:); % remove off bottom
        moveTo = opts(data(sub2ind(size(data),opts(:,1),opts(:,2))) <=...
        data(r,c) + 1,:); % find where move is possible (@ most one higher)
        to  = "Tree" + moveTo(:,1) + "_" + moveTo(:,2); % change to node
        d = addedge(d,"Tree" + r + "_" + c,to); % add edges
    end
end

bestSignalNode = "Tree" + bestSignalR + "_" + bestSignalC;
startNode = "Tree" + startR + "_" + startC;
path = shortestpath(d,startNode,bestSignalNode);
day12puzzle1result = numel(path)-1 %#ok<NOPTS> 


coords = reshape(path.erase("Tree").split("_").double(),[],2);
plot(coords(:,1),coords(:,2))

