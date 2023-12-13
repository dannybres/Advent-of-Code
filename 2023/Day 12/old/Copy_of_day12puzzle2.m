%% day12puzzle2 - Daniel Breslan - Advent Of Code 2023
clc
profile on
tic
data = readlines("input.txt");
r = nan(numel(data),1);
% global mf
mf = memoize(@processLine);
parfor idx = 1:numel(data)
    springs = char(repmat(data(idx).extractBefore(" "),1,5).join("?") + ".");
    counts = repmat(data(idx).extractAfter(" ").extract(digitsPattern).double,5,1);
    r(idx) = processLine(springs,counts,0,mf);
    disp(compose("line: %i has %i combos", idx,r(idx)))
end
day12puzzle2result = sum(r) %#ok<NOPTS> 
toc
profile viewer