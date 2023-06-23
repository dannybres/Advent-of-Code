%% day19puzzle1 - Daniel Breslan - Advent Of Code 2019
addpath("../intCodeComputer/")
data = readlines("inputDemo.txt").split(",").double();
out = nan(50)
for r = 0:49
    for c = 0:49
        out(r+1, c+1) = processIntCodeComputer(data,[r c]);
    end
end
out
day19puzzle1result = 0;
