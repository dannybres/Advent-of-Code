%% day10puzzle1 - Daniel Breslan - Advent Of Code 2021
data = readlines("input.txt");
lastlength = 0;

reducedData = data;
while lastlength ~= reducedData.join.strlength
    lastlength = reducedData.join.strlength;
    reducedData = reducedData.erase(["()","[]","<>","{}"]);
end

simpleReducedData = reducedData.replace(["(" "{" "[" "<" ")" "}" "]" ">"], ...
    repelem(["s" "e"],1,4))

st = regexp(simpleReducedData,"se");
idx = ~cellfun(@isempty,st);
reducedData = reducedData(idx);
st = st(idx);

day10puzzle1result = sum((reducedData.extractBetween(cell2mat(st)+1, ...
    cell2mat(st)+1) == [")","]","}",">"]) .* [3 57 1197 25137],'all') %#ok<NOPTS> 