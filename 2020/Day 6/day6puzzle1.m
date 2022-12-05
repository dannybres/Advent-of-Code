%% day6puzzle1 - Daniel Breslan - Advent Of Code 2020
data = readlines("input.txt").join().split("  ").replace(" ","");

sum(arrayfun(@numberOfUniqueChars,data))

function out = numberOfUniqueChars(in)
    in = in.split("");
    in = in(2:end-1);
    out = numel(unique(in));
end