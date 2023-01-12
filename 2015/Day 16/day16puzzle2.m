%% day16puzzle2 - Daniel Breslan - Advent Of Code 2015
% had a look at the reddit for some clues :(
data = readlines("input.txt").split("").double;
data = data(2:end-1)';
messageOffset = sum(data(1:7) .* 10.^(6:-1:0));
data = repmat(data,1,10000);
data = data(messageOffset+1:end);
n = 100;
for phase = 1:n
    data = mod(cumsum(data,"reverse"),10);
end
data(1:8)
day16puzzle2result = string(data(1:8)).join("") %#ok<NOPTS> 