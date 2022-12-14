%% day7puzzle1 - Daniel Breslan - Advent Of Code 2019
addpath("../intCodeComputer/")
data = split(readlines("input.txt"),",").double();
options = perms(0:4);
maxThrust = 0;
for optIdx = 1:height(options)
    out = 0;
    for idx = options(optIdx,:)
        out = processIntCodeComputer(data,[idx out]);
    end
    if out > maxThrust
        maxThrust = out;
    end
end
day7puzzle1result = maxThrust %#ok<NOPTS>