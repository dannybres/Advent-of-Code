%% day8puzzle1 - Daniel Breslan - Advent Of Code 2018
data = readlines("input.txt").split(" ").double();

[~,day8puzzle1result] = process(data,0) %#ok<NOPTS> 

function [data,metaCount] = process(data,metaCount)
    nCh = data(1); % get num children
    nMe = data(2); % get num meta
    data = data(3:end); % dispose of header

    for idx = 1:nCh % process childs recursively
        [data,metaCount] = process(data,metaCount);
    end

    meta = sum(data(1:nMe)); % get meta (now children have finished)
    metaCount = metaCount + meta; % increment count
    data(1:nMe) = []; % dispose of meta
end