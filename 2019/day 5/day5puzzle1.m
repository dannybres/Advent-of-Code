%% day5puzzle1 - Daniel Breslan - Advent Of Code 2019
data = readlines("input.txt").split(",").double();
outputs = runIntcode(data,1); 
day5puzzle1results = outputs(end) %#ok<NOPTS> 