%% day15puzzle1 - Daniel Breslan - Advent Of Code 2022
data = readlines("input.txt").erase(["Sensor at x=", " y=",...
    "closest beacon is at x="]).replace(": ",",").split(",").double();
r = 2000000;

t = array2table(data,VariableNames=["sx","sy","bx","by"]);
t = [t table(abs(t.sy-t.by) + abs(t.sx-t.bx),VariableNames="md")];
from = t.sx - t.md + abs(t.sy-r);
to = t.sx + t.md - abs(t.sy-r);
from(from > to) = nan;
to(isnan(from)) = nan;
t = [t table(from, to)];

ranges = t{~isnan(t.to),["from","to"]};

res = ranges(1,:);
for idx = 2:size(ranges,1)
    thisRange = ranges(idx,:);
    overlap = any([thisRange(1) <= res(:,2) thisRange(2) >= res(:,1)]);
    allRangesExisting = res(overlap,:);
    allRangesExisting = [allRangesExisting(:); thisRange(:)];
    res(overlap,:) = [];
    res = [res; [min(allRangesExisting) max(allRangesExisting)]];
end
unBea = unique(t{t.by == r,["bx","by"]},"rows");
day15puzzle1result = res(2) - res(1) + 1 - size(unBea,1)