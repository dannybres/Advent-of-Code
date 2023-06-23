%% day2puzzle1 - Daniel Breslan - Advent Of Code 2018
data = readlines("input.txt");
q = arrayfun(@twoOrThreeDuplicates,data, 'UniformOutput',false);
day2puzzle1result = prod(sum(cell2mat(q))) %#ok<NOPTS> 
