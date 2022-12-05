%% day1puzzle2 - Daniel Breslan - Advent Of Code 2019
data = readlines("input.txt").double();

extra = zeros(1,numel(data));
for idx = 1:numel(data)
    a = data(idx);
    fna = fn(a);
    while fna > 0
        extra(idx) = extra(idx) + fna;
        fna = fn(fna);
    end
end
day1puzzle2result = sum(extra)

function out = fn(in)
out = floor(in/3)-2;
end