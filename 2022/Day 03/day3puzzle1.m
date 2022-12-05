%% day3puzzle1 - Daniel Breslan - Advent Of Code 2022
data = readlines("input.txt");

comps = [data.extractBefore(strlength(data)/2+1)...
    data.extractAfter(strlength(data)/2)];

commontype = strings(height(comps),1);

for idx = 1:height(comps)
    a = comps(idx,1).split("");
    b = comps(idx,2).split("");
    comvals = intersect(a,b);
    commontype(idx) = comvals(end);
end
day3puzzle1result = sum(convertToPriority(commontype))


function out = convertToPriority(in)
out = double(char(in))
out(out<double('a')) = out(out<double('a')) - double('A') + 27
out(out>double('a')) = out(out>double('a')) - double('a') + 1
end
