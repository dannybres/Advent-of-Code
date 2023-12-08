%% day8puzzle1 - Daniel Breslan - Advent Of Code 2023
data = readlines("input.txt");
d = data(1); d = d.split(""); d = d(2:end-1);
m = dictionary(reshape(data(3:end).extractBefore(" ")'+["L";"R"],[],1), ...
    reshape(data(3:end).extractBetween("(",")").split(", ")',[],1));

loc = "AAA";
idx = 1;
while loc ~= "ZZZ"
    loc = m(loc+getDir(idx,d));
    idx = idx + 1;
end

day8puzzle1result = idx -1

function dir = getDir(n,d)
    n = mod(n,numel(d));
    if  n == 0
        n = numel(d);
    end
    dir = d(n);
end