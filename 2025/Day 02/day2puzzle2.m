%% day2puzzle2 - Daniel Breslan - Advent Of Code 2025
data = readlines("input.txt").split(",").split("-").double();

day2puzzle2result = 0;
for dIdx = 1:height(data)
    ids = string(data(dIdx,1):data(dIdx,2));
    idLengths = strlength(ids);
    idUniqueLengths = unique(idLengths);

    invalidIds = [];
    for idl = idUniqueLengths
        sids = char(ids(idl == idLengths)');
        options = find(~mod(idl./(1:floor(idl/2)),1));
        for op = options
            b = reshape(sids,height(sids),op,[]);
            invalidIds = [invalidIds;string(sids(all(all(b == b(:,:,1),2),3),:)).double()];
        end
    end
    day2puzzle2result = day2puzzle2result + sum(unique(invalidIds));
end
format longg
day2puzzle2result