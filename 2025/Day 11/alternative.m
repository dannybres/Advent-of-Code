data = readlines("input.txt");

graph = dictionary;

for idx = 1:numel(data)
    graph(data(idx).extractBefore(": ")) = ...
        {data(idx).extractAfter(": ").split(" ")'};
end

part1 = countPaths("you", "out", graph)

part2 = countPaths("svr", "dac", graph) * countPaths("dac", "fft", graph) * countPaths("fft", "out", graph) + ...
countPaths("svr", "fft", graph) * countPaths("fft", "dac", graph) * countPaths("dac", "out", graph)

function out = countPaths(src, dst, g)
    persistent memo
    if isempty(memo)
        memo = dictionary(string.empty, double.empty);
    end
    k = src + "->" + dst;
    if isKey(memo,k)
        out = memo(k);
        return
    end
    if src == dst
        out = 1;
        memo(k) = out;
        return
    end
    if isKey(g,src)
        next = g(src);
        next = next{:};
    else
        next = [];
    end
    tot = 0;
    for idx = 1:numel(next)
        tot = tot + countPaths(next(idx), dst, g);
    end
    memo(k) = tot;
    out = tot;
end


