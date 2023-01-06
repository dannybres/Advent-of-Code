%% day7puzzle2 - Daniel Breslan - Advent Of Code 2019
addpath("../intCodeComputer/")
data = split(readlines("input.txt"),",").double();
% data = dictionary(1:numel(data),data');

options = perms(5:9);
maxThrust = 0;

for optIdx = 1:height(options)
    outputs = zeros(5,1);
    terminated = false(5,1);
    dataInProcess = repmat({data},1,5);
    idxInProcess = zeros(5,1);
    for map = 1:10
        for ampNum = 1:5
            previousAmp = ampNum - 1;
            if previousAmp == 0
                previousAmp = 5;
            end
            input = [options(optIdx,ampNum) outputs(previousAmp)];
            if map ~= 1
                input = input(2);
            end
            [outputs(ampNum), dataInProcess{ampNum}, idxInProcess(ampNum),...
                terminated(ampNum)] = processIntCodeComputer(dataInProcess{ampNum},...
                input,1,idxInProcess(ampNum));
        end
        if all(terminated)
            break
        end
        priorOutput = outputs;
    end

    if priorOutput(end) > maxThrust
        maxThrust = priorOutput(end);
    end
end

day7puzzle2result = maxThrust %#ok<NOPTS> 