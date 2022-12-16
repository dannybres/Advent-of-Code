%% day15puzzle2 - Daniel Breslan - Advent Of Code 2022
data = readlines("input.txt").erase(["Sensor at x=", " y=",...
    "closest beacon is at x="]).replace(": ",",").split(",").double();
data = [data zeros(size(data,1),3)];
sz = 4e6; 
for r = 1:sz
    data(:,5) = abs(data(:,2)-data(:,4)) + abs(data(:,1)-data(:,3));
    from = data(:,1) - data(:,5) + abs(data(:,2)-r);
    to = data(:,1) + data(:,5) - abs(data(:,2)-r);
    from(from > to) = nan;
    to(isnan(from)) = nan;
    data(:,6) = from;
    data(:,7) = to;
    ranges = min(max(data(~isnan( data(:,7)),6:7), 1),sz);
 
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
        break
    end
end
day15puzzle2result = (res(1,2) + 1) * 4000000 + r %#ok<NOPTS>