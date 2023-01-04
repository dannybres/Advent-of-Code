%% day7puzzle1 - Daniel Breslan - Advent Of Code 2019
addpath('../day 5/')
data = split(readlines("input.txt"),",").double();

options = perms(0:4);
maxThrust = 0;
for optIdx = 1:height(options)
    out = 0;
    for idx = options(optIdx,:)
        out = runIntcode(data,[idx out]);
    end
    if out > maxThrust
        maxThrust = out;
    end
end
day7puzzle1result = maxThrust; %#ok<NOPTS>

isIntComputerWorking = day7puzzle1result == 338603