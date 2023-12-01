%% day1puzzle1 - Daniel Breslan - Advent Of Code 2023
data = readlines("input.txt");
nums = regexp(data,"\d",'match');
fun = @(x) x([1 end]).join("").double;
day1puzzle1result = sum(cell2mat(cellfun(fun,nums,UniformOutput=false)))
