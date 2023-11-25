%% day12puzzle2 - Daniel Breslan - Advent Of Code 2018
data = readlines("input.txt");
pots = data(1).split(" ");
pots = find(char(pots(end)) == '#') - 1;

list = data(3:end).split(" => ");
lookup = dictionary(list(:,1),list(:,2));

lookup = char(list(:,1)) == '#';
res = char(list(:,2)) == '#';
n = 200;
sums = zeros(n,1);

for gidx = 1:n
    newPots = [];
    for idx=min(pots)-2:max(pots)+4
        rangeToCheck = idx-2:idx+2;
        toFind = any(rangeToCheck == pots');
        matches = ismember(lookup,toFind,'rows');
        match = find(matches);
        if res(match)
            newPots = [newPots idx]; %#ok<AGROW> 
        end
    end
    pots = newPots;
    sums(gidx) = sum(pots);
end

day12puzzle1result = sums(end) + (50000000000 - n) * diff(sums(end-1:end)) %#ok<NOPTS> 
