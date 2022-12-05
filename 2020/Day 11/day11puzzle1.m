%% day11puzzle1 - Daniel Breslan - Advent Of Code 2020
data = readlines("input.txt");
data = data.split("");
data = data(:,2:end-1);
do = "a";
while any(do ~= data,'all')
    do = data;
    data(shouldEmpty(do)) = "L";
    data(noOccupiedSeatsAdjacent(do)) = "#";
end
sum(data == "#",'all')

function map = noOccupiedSeatsAdjacent(mapIn)
map = mapIn == "L" | mapIn == ".";
map = conv2(padarray(map,[1 1],true),[1 1 1;1 0 1;1 1 1],'same') == 8;
map = map(2:end-1,2:end-1);
map = map & mapIn == "L";
end

function map = shouldEmpty(mapIn)
map = mapIn == "#";
map = conv2(map,[1 1 1;1 0 1;1 1 1],'same') >= 4;
map = map & mapIn == "#";
end