%% day8puzzle1 - Daniel Breslan - Advent Of Code 2019
w = 25;
h = 6;

data = readlines("input.txt").split("");
data = data(2:end-1).double;
data = reshape(data,w*h,[]);

minLayer = find(sum(data == 0) == min(sum(data == 0)));

prod(sum(data(:,minLayer) == [1 2]))

day8puzzle1result = prod(sum(data(:,minLayer) == [1 2])) %#ok<NOPTS> 