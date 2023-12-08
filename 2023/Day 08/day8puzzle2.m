%% day8puzzle1 - Daniel Breslan - Advent Of Code 2023
data = readlines("input.txt");
d = data(1); d = d.split(""); d = d(2:end-1);
d = repmat(d,100,1);
m = dictionary(reshape(data(3:end).extractBefore(" ")'+["L";"R"],[],1), ...
    reshape(data(3:end).extractBetween("(",")").split(", ")',[],1));

locs = data(3:end).extractBefore(" ");
locs = locs(locs.extract(3) == "A");

zs = nan(1,numel(locs));

idx = 1;
while any(isnan(zs))
    locs = m(locs+d(idx));
    zs(locs.extract(3) == "Z") = idx;
    idx = idx + 1;
end
format long
day8puzzle2result = lcm(lcm(lcm(lcm(lcm(zs(1),zs(2)),zs(3)),zs(4)),zs(5)),zs(6)) %#ok<NOPTS> 