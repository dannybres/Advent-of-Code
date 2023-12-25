%% day25puzzle1 - Daniel Breslan - Advent Of Code 2023
data = readlines("input.txt");
d = graph;
for idx = 1:numel(data)
    node = data(idx).extractBefore(":");
    for to = data(idx).extractAfter(": ").split(" ")'
        d = addedge(d,node,to);
    end
end
plot(d)
d = rmedge(d,'zns','jff');
d = rmedge(d,'nvb','fts');
d = rmedge(d,'kzx','qmr');
plot(d)
c = conncomp(d);
day25puzzle1result = sum(c==1)*sum(c==2);