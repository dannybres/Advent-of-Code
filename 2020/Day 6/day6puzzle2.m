%% day6puzzle2 - Daniel Breslan - Advent Of Code 2020
data = readlines("input.txt").join().split("  ").replace(" ",",");

sum(arrayfun(@numberOfCommonChars,data))

function out = numberOfCommonChars(in)
    allUniqueInput = char(string(unique(char(in))).erase(","));
    in = in.split(",");
    found = false(numel(in),numel(allUniqueInput));
    for idx = 1:numel(in)
        found(idx,:) = any(char(allUniqueInput) == char(in(idx))',1);
    end
    out = sum(all(found,1));
end

figure(Units="normalized",Position=[0 0 1 1])