%% day9puzzle1 - Daniel Breslan - Advent Of Code 2023
data = readlines("input.txt").split(" ").double;
summer = 0;
for idx = 1:height(data)
    p = polyfit(1:width(data),data(idx,:),width(data)-1);
    summer = summer + round(polyval(p,width(data)+1));
end
day9puzzle1result = summer %#ok<NOPTS> 