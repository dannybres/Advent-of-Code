%% day11puzzle1 - Daniel Breslan - Advent Of Code 2025
data = readlines("inputDemo.txt")

s = data.extractBefore(":")
t = strtrim(data.extractAfter(":"))

f = @(x) mat2cell(x.split(" "))

arrayfun(f,t)


day11puzzle1result = 0;
