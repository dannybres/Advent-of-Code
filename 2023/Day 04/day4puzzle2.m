%% day4puzzle2 - Daniel Breslan - Advent Of Code 2023
data = readlines("input.txt").split([":" "|"]);
 
data = data(:,2:end).replace("  "," ").replace("  "," ")...
    .replace("  "," ");
 
winners = data(:,1).split(" ");
winners = winners(:,~all(winners == "")).double;
my = data(:,2).split(" ");
my = my(:,~all(my == "")).double;
 
r = nan(height(winners),1);
n = ones(height(winners),1);
for idx = 1:height(winners)
    r(idx) = sum(winners(idx,:) == my(idx,:)',"all");
    if r(idx) > 0
    n(idx+1:idx+r(idx)) = n(idx+1:idx+r(idx)) + n(idx);
    end
end

day4puzzle2result = sum(n) %#ok<NOPTS>