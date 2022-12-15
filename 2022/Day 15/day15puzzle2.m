%% day15puzzle2 - Daniel Breslan - Advent Of Code 2022
data = readlines("input.txt").erase(["Sensor at x=", " y=",...
    "closest beacon is at x="]).replace(": ",",").split(",").double();

sz = 4000000;
for r = 97100:sz
    if mod(r,1000) == 0
        disp(r)
    end
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
        overlap = (res(:,1) <= thisRange(1) & res(:,2) >= thisRange(1))|...
            (res(:,1) <= thisRange(2) & res(:,2) >= thisRange(2))|...
            (thisRange(1) < res(:,1) & thisRange(2) > res(:,2));
        allRangesExisting = res(overlap,:);
        allRangesExisting = [allRangesExisting(:); thisRange(:)];
        res(overlap,:) = [];
        res = [res; [min(allRangesExisting) max(allRangesExisting)]]; %#ok<AGROW>
    end
    if size(res,1) > 1
        res
        break
    end
end
(res(1,2) + 1) * 4000000 + r
