%% day8puzzle1 - Daniel Breslan - Advent Of Code 2023
clc
data = readlines("input.txt");
d = data(1); d = d.split(""); d = d(2:end-1);
m = dictionary(reshape(data(3:end).extractBefore(" ")'+["L";"R"],[],1), ...
    reshape(data(3:end).extractBetween("(",")").split(", ")',[],1));

locs = data(3:end).extractBefore(" ");
locs = locs(locs.extract(3) == "A");
zs = cell(1,numel(locs));

idx = 1;
while any(cellfun(@isempty,zs))
    locs = m(locs+getDir(idx,d));
    if any(locs.extract(3) == "Z")
        zidxs = find(locs.extract(3) == "Z");
        for zidx = zidxs'
            zs{zidx} = [zs{zidx} idx];
        end
    end
    idx = idx + 1;
end
q = cell2mat(cellfun(@(x) x(1),zs,'UniformOutput',false)');
format long
day8puzzle2result = lcm(lcm(lcm(lcm(lcm(q(1),q(2)),q(3)),q(4)),q(5)),q(6)) %#ok<NOPTS> 


function dir = getDir(n,d)
    n = mod(n,numel(d));
    if  n == 0
        n = numel(d);
    end
    dir = d(n);
end