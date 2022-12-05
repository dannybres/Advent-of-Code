%% day4puzzle1 - Daniel Breslan - Advent Of Code 2022
data = readlines("input.txt").replace("-",",")...
    .split(",").double();

day4puzzle1result = sum((data(:,1) >= data(:,3) & data(:,2) <= data(:,4)) |...
    (data(:,3) >= data(:,1) & data(:,4) <= data(:,2))) %#ok<NOPTS> 



