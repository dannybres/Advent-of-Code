%% day10puzzle2 - Daniel Breslan - Advent Of Code 2025
clc
data = readlines("input.txt");
day10puzzle2result = 0;
a = 0;
for dataIdx = 1:numel(data)
    machineInfo = data(dataIdx).split(" ");

    target = machineInfo(end).extract(digitsPattern).double';
    numButtons = numel(machineInfo) - 2;

    buttonOutputs = false(numButtons, numel(target));
    for idx = 2:numel(machineInfo) -1
        buttonOutputs(idx-1,machineInfo(idx)...
            .extract(digitsPattern).double + 1) = true;
    end
    opts = optimoptions('intlinprog', 'Display', 'off');
    presses = sum(intlinprog(ones(numButtons,1), 1:numButtons, [], [], ...
        double(buttonOutputs)', target', zeros(numButtons,1),[],opts));
    
    day10puzzle2result = day10puzzle2result + presses;
end

day10puzzle2result