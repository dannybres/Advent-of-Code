%% day9puzzle2 - Daniel Breslan - Advent Of Code 2023
data = readlines("input.txt").split(" ").double;
summer = 0;
for idx = 1:height(data)
    summer = summer + round(polyval( ...
        polyfit(1:width(data),data(idx,:),width(data)-1),0));
end
day9puzzle2result = summer %#ok<NOPTS> 