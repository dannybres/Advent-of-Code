%% day4puzzle2 - Daniel Breslan - Advent Of Code 2023
data = readlines("input.txt");
winners = data.extractBetween(":","|").extract(digitsPattern).double;
my = data.extractAfter("|").extract(digitsPattern).double;
 
n = ones(height(winners),1);
for idx = 1:height(winners)
    r = sum(winners(idx,:) == my(idx,:)',"all");
    n(idx+1:idx+r) = n(idx+1:idx+r) + n(idx);
end

day4puzzle2result = sum(n) %#ok<NOPTS>