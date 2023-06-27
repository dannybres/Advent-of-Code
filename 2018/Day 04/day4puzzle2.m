%% day4puzzle2 - Daniel Breslan - Advent Of Code 2018
data = readlines("input.txt");

t = createDataTable(data); % help to parse data into matlab vars

guardT = createGuardTable(t); % parse data into guard per min matrix 
% & add total count

[gr,gu] = findgroups(guardT.guard); % sum instances of sleep
sleepInstances = splitapply(@sum, guardT{:,3:end-1},gr);

[r,c] = ind2sub(size(sleepInstances),...
    find(sleepInstances == max(sleepInstances,[],'all'))); % find highest

day4puzzle2result = gu(r) * (c - 1)%#ok<NOPTS> 