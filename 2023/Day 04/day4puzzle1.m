%% day4puzzle1 - Daniel Breslan - Advent Of Code 2023
% Thanks eMoss - https://discord.com/channels/315631984489791488/452325884955852800/1181343396577677373
data = readlines("input.txt");
win = data.extractBetween(":","|").extract(digitsPattern).double;
game = data.extractAfter("|").extract(digitsPattern).double;
numMatches = sum(reshape(win,height(win),1,[]) == game,[2 3]);

day4puzzle1result = sum(floor(2.^(numMatches-1))) %#ok<NOPTS>
