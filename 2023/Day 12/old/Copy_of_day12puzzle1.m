%% day12puzzle1 - Daniel Breslan - Advent Of Code 2023
clc
tic
clearAllMemoizedCaches
data = readlines("input.txt");
r = nan(numel(data),1);   
% mf = memoize(@processLine);
for idx = 1:numel(data)
    springs = char(data(idx).extractBefore(" ") + ".");
    counts = data(idx).extractAfter(" ").extract(digitsPattern).double;

    % springs = char(repmat(data(idx).extractBefore(" "),1,5).join("?") + ".");
    % counts = repmat(data(idx).extractAfter(" ").extract(digitsPattern).double,5,1);

    r(idx) = processLine(springs,counts,0);
    disp(compose("line: %i has %i combos", idx,r(idx)))
end
day12puzzle1result = sum(r) %#ok<NOPTS>
toc
% profile viewer