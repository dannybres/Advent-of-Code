%% day14puzzle1 - Daniel Breslan - Advent Of Code 2021
data = readlines("input.txt");
line = data(1);
comms = data(3:end).split(" -> ");
% comms(:,2) = comms(:,1).insertAfter(1,comms(:,2))
for ridx = 1:10
    for idx = 1:2:2*(line.strlength()-1)
        line = line.insertAfter(idx,comms(line.extractBetween(idx,idx+1) == comms(:,1),2));
    end
end
counts =  sum(char(line)' == unique(char(line)));
day14puzzle1result = max(counts)-min(counts)
