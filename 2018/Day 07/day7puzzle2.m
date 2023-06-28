%% day7puzzle2 - Daniel Breslan - Advent Of Code 2018
data = readlines("input.txt")...
    .split(" must be finished before step ")...
    .erase(["Step "," can begin."]);
d = digraph(table(data,'VariableNames',{'EndNodes'}));


r = 2e3; % table rows - guess
w = 5; % workers
p = 60; % time to complete

t = [table((0:r)',VariableNames="Second") ...
    array2table(repmat(".",r+1,w),"VariableNames","Worker " + (1:w)) ...
    array2table(repmat("",r+1,1),"VariableNames","Done")]; % build table 
% like AoC site

s = 0; % current seconds
nodesStarted = repmat("",1,d.numnodes); % nodes visited with some dummy data.
while d.numnodes > 0 % go until all visited.
    if t.Done(s+1) ~= ""
        d = d.rmnode(t.Done(s+1)); % is done in this second then remove it.
    end
    
    % check available workers (.)this second
    currentWorkerState = t{s+1,2:1+w};
    availableWorkers = find(currentWorkerState == "."); 
    
    % find available paths, in graph, no edges into and nor started
    unVisitedNodes = string(d.Nodes.Name); 
    nodeWithIn = unique(string(d.Edges.EndNodes(:,2)));
    availableNodes = sort(unVisitedNodes(...
        ~any(unVisitedNodes == nodeWithIn',2))); 
    availableNodes = ...
        availableNodes(~ismember(availableNodes,nodesStarted));
    
    % start all worker working
    for idx = 1:min(numel(availableWorkers), numel(availableNodes))
        % add the working time to occupy worker
        timeToComp = p + ...
            double(char(availableNodes(idx))) - double('A') + 1;
        t(s+1:s+timeToComp,"Worker " + availableWorkers(idx)) = ...
            {availableNodes(idx)};
        
        % record work has started
        nodesStarted(find(nodesStarted == "",1)) = availableNodes(idx);

        % record when finished.
        t.Done(s+timeToComp+1) = availableNodes(idx);
    end
    
    s = s + 1; % increment second
end

day7puzzle2result = s-1 %#ok<NOPTS> % finished on prior second 
% (last node removed from grpah in final second) 
