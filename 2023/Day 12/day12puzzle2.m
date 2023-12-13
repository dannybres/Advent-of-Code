%% day12puzzle1 - Daniel Breslan - Advent Of Code 2023
tic
data = readlines("input.txt");
r = nan(height(data),1);
for idx = 1:numel(data)
    springs = char(repmat(data(idx).extractBefore(" "),1,5).join("?") + ".");
    counts = repmat(data(idx).extractAfter(" ").extract(digitsPattern).double,5,1);
    r(idx) = processLines(springs,counts);
end
day13puzzle1result = sum(r) %#ok<NOPTS>
toc