%% day12puzzle2 - Daniel Breslan - Advent Of Code 2023
clc
data = readlines("inputDemo.txt");
r = nan(numel(data),1);
% global d %#ok<GVMIS> 
% d = dictionary("1",2);
mf = memoize(@processLine);
for idx = 1:numel(data)
    springs = char(repmat(data(idx).extractBefore(" "),1,5).join("?") + ".");
    counts = repmat(data(idx).extractAfter(" ").extract(digitsPattern).double,5,1);
    r(idx) = processLine(springs,counts,0);
    disp(compose("line: %i has %i combos", idx,r(idx)))
end
day12puzzle2result = sum(r) %#ok<NOPTS> 