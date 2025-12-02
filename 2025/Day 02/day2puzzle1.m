%% day2puzzle1 - Daniel Breslan - Advent Of Code 2025
data = readlines("input.txt").split(",").split("-").double();

day2puzzle1result = 0;
for dIdx = 1:height(data)
    ids = string(data(dIdx,1):data(dIdx,2));
    idLengths = strlength(ids);

    ids(logical(mod(idLengths,2))) = []; % remove odd lengths
    idLengths(logical(mod(idLengths,2))) = [];

    halfIdLength = idLengths/2;
    day2puzzle1result = day2puzzle1result + ...
        sum(ids(ids.extractBefore(halfIdLength+1) == ...
        ids.extractAfter(halfIdLength)).double);
end
format longg
day2puzzle1result

%% Alternative solution - TIL Numerical References in RegEx
day2puzzle1result = 0;
for dIdx = 1:height(data)
    ids = string(data(dIdx,1):data(dIdx,2));
    day2puzzle1result = day2puzzle1result + sum(ids(~cellfun(@isempty,regexp(ids,"^(.+)\1$"))).double);
end
format longg
day2puzzle1result