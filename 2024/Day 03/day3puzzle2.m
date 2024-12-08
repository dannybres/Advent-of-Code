%% day3puzzle2 - Daniel Breslan - Advent Of Code 2024
data = readlines("input.txt").join("");
day3puzzle1result = multiplications(data)
day3puzzle2result = multiplications(regexprep(data,"don't\(\).*?do\(\)",""))

function out = multiplications(in)
[s,e] = regexp(in,"mul\(\d+,\d+\)");
out = 0;
for idx = 1:numel(s)
    out = out + ...
        prod(double(in.extractBetween(s(idx),e(idx)).extract(digitsPattern)));
end
end
