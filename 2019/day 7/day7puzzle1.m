%% day7puzzle1 - Daniel Breslan - Advent Of Code 2019
% addpath("/Users/danielbreslan/Library/Mobile Documents/com~apple~" + ...
%     "CloudDocs/Documents/MATLAB/211202 advent of code/2019/day 5/")
clc
data = split(readlines("inputDemo.txt"),",").double();

options = [9,8,7,6,5];
optIdx = 1
for idx = 1:height(options)
    options(idx,:)
    outputs = zeros(5,1);
    terminated = false(5,1);
    dataInProcess = repmat(data,1,5);
    idxInProcess = ones(5,1);
    for a = 1:5
        for ampNum = 1:5
            previousAmp = ampNum - 1;
            if previousAmp == 0
                previousAmp = 5;
            end
            [outputs(ampNum), dataInProcess(:,ampNum), idxInProcess(ampNum),...
                terminated(ampNum)] = runIntcode(dataInProcess(:,ampNum),...
                [options(idx,ampNum) outputs(previousAmp)],1,idxInProcess(ampNum))
        end
        outputs
        idxInProcess
    end

end

% [outputs, data, idx, terminated] = runIntcode(pro,[idx(1) 0],1)


% options = perms(0:4);
% maxThrust = 0;
% for optIdx = 1:height(options)
%     out = 0;
%     for idx = options(optIdx,:)
%         out = runIntcode(pro,[idx out]);
%     end
%     if out > maxThrust
%         maxThrust = out;
%     end
% end
% day7puzzle1result = maxThrust %#ok<NOPTS>