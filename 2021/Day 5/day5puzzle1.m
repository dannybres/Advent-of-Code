%% day5puzzle1 - Daniel Breslan - Advent Of Code 2021
data = readtable("input.txt",Delimiter={',',' -> '});
data.Properties.VariableNames = ["x1","y1","x2","y2"];

data{:,["x1" "x2"]} = sort(data{:,["x1" "x2"]},2);
data{:,["y1" "y2"]} = sort(data{:,["y1" "y2"]},2);

straights = data(data.x1 == data.x2 | data.y1 == data.y2,:);

sizes = max(table2array(straights));
map = zeros(max(sizes([2 4]))+1,max(sizes([1 3]))+1);

for idx = 1:height(straights)
    yIndexOfVent = (straights{idx,"y1"}:straights{idx,"y2"})+1;
    xIndexOfVent = (straights{idx,"x1"}:straights{idx,"x2"})+1;
    map(yIndexOfVent, xIndexOfVent) = map(yIndexOfVent, xIndexOfVent)+1;
end

day5puzzle1result = sum(map > 1,'all') %#ok<NOPTS> 

