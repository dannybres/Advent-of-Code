%% day4puzzle1 - Daniel Breslan - Advent Of Code 2018
data = readlines("input.txt");

t = createDataTable(data); % help to parse data into matlab vars

guardT = createGuardTable(t); % parse data into guard per min matrix 
% & add total count

[gr,gu] = findgroups(guardT.guard); % find hoe long each guard is asleep
summary = table(gu,splitapply(@sum,guardT.("total asleep"),gr),...
    VariableNames=["guard","total asleep"]);

guardAsleepMost = summary{summary.("total asleep") == ...
    max(summary.("total asleep")),"guard"}; % find guard asleep most

minutesAsleep = sum(guardT{guardT.guard == guardAsleepMost,3:end-1}); 

mostFreqAsleep = find(minutesAsleep == max(minutesAsleep)) - 1;

day4puzzle1result = guardAsleepMost * mostFreqAsleep %#ok<NOPTS> 
