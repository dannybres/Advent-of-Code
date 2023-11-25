%% day11puzzle1 - Daniel Breslan - Advent Of Code 2018
sn = 5791;
m = powerLevel(sn);
kernel = ones(3);
result = conv2(m, kernel, 'same');
[x,y] = ind2sub(size(m),find(result == max(result,[],"all")));

day11puzzle1result = compose("%i,%i",y-1,x-1) %#ok<NOPTS> 