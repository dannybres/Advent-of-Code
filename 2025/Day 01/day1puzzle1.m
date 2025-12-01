%% day1puzzle1 - Daniel Breslan - Advent Of Code 2025
data = readlines("input.txt");
dir = data.extract(1);
num = str2double(data.extractAfter(1));

num(dir  == "L") =  -num(dir  == "L");
day1puzzle1result = nnz(mod(50 + cumsum(num),100) == 0);