%% day6puzzle1 - Daniel Breslan - Advent Of Code 2021
data = readmatrix("input.txt");
data = histcounts(data,0:9);

for idx = 1:256
    data = circshift(data,-1);
    data(7) = data(7) + data(end);
end

format long g
day6puzzle1result = sum(data)