%% day12puzzle1 - Daniel Breslan - Advent Of Code 2023
tic
data = readlines("input.txt");
r = nan(height(data),1);
for idx = 1:numel(data)
    springs = char(data(idx).extractBefore(" ") + ".");
    counts = data(idx).extractAfter(" ").extract(digitsPattern).double;
    r(idx) = processLines(springs,counts);
end
day13puzzle1result = sum(r) %#ok<NOPTS>
toc