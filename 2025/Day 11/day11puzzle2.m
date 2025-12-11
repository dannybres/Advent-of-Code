%% day11puzzle2 - Daniel Breslan - Advent Of Code 2025
data = readlines("input.txt")

a = data.extractBefore(":");
b = strtrim(data.extractAfter(":"));
s = strings(sum(b.count(" ")) + height(b),1);
t = s;

ai = 1;
for idx = 1:height(b)
    c = b(idx).split(" ");
    s(ai:ai + numel(c) - 1) = a(idx);
    t(ai:ai + numel(c) - 1) =  c';
    ai = ai + numel(c);

end

d = digraph(s,t);
route = ["svr" "fft" "dac" "out"];
day11puzzle1result = 1
for idx = 1:numel(route)-1
    ap = allpaths(d,route(idx),route(idx+1));
    day11puzzle1result = day11puzzle1result * height(ap)
end
day11puzzle1result

