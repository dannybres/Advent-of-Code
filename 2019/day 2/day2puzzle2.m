%% day2puzzle2 - Daniel Breslan - Advent Of Code 2019
addpath("../intCodeComputer/")

dataOriginal = readlines("input.txt").split(",").double();
options = [repelem(0:99,1,99); repmat(0:99,1,99)];
for optIdx = options
    data = dataOriginal;
    data(2:3) = optIdx;
    [~, data] = processIntCodeComputer(data,1);
    if data(0) == 19690720
        break
    end
end

day2puzzle2result = sum(optIdx .* [100; 1]) %#ok<NOPTS>