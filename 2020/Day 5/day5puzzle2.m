%% day5puzzle2 - Daniel Breslan - Advent Of Code 2020
data = readlines("input.txt");

row = bin2dec(data.extractBefore(8).replace("F","0").replace("B","1"));
seat = bin2dec(data.extractAfter(7).replace("L","0").replace("R","1"));
t = table(row,seat);
t = sortrows(t,{'row','seat'});
nextSeat = t(diff(t.seat) == 2,:);

day5puzzle2result = nextSeat.row * 8 + nextSeat.seat + 1