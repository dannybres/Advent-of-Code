%% day5puzzle2 - Daniel Breslan - Advent Of Code 2023
data = readlines("input.txt");
ranges = reshape(data(1).extract(digitsPattern).double,2,[])';
ranges(:,2) = sum(ranges,2) - 1;
data = data(3:end);
levelPoints = [[1;find(data == "")+1],[find(data == "")-1;numel(data)]];
for idx = 1:height(levelPoints)
    d = data(levelPoints(idx,1)+1:levelPoints(idx,2))...
        .extract(digitsPattern).double;
    map = [d(:,2) d(:,2) + d(:,3) - 1, diff(d(:,2:-1:1),[],2)];
    [~,srtIdx] = sort(map(:,1));
    map = map(srtIdx,:);
    ranges = splitRanges(map, ranges);
    ranges = translateToNextMap(ranges, map);
end
day5puzzle2result = min(ranges,[],"all") %#ok<NOPTS>

function rr = splitRanges(map, ranges)
rr = [];
for idx = 1:height(ranges)
    tempRan = nan(height(map),2);
    rtp = ranges(idx,:);
    tempRan(map(:,1:2) > rtp(1) & map(:,1:2) < rtp(2)) =...
        map(map(:,1:2) > rtp(1) & map(:,1:2) < rtp(2));
    tempRan(all(isnan(tempRan),2),:) = [];
    if ~isempty(tempRan)
        tempRan = [rtp(1), nan;...
            tempRan;...
            nan, rtp(2)];
        tempRan = tempRan';
        tempRan = tempRan(:);
        trin = isnan(tempRan);
        for tidx = numel(trin)-1:-2:2
            if all(trin(tidx-1:tidx))
                tempRan(tidx-1:tidx) = [];
            end
        end
        tempRan = reshape(tempRan,2,[])';
        c1i = find(isnan(tempRan(:,1)));
        tempRan(c1i,1) = tempRan(c1i-1,2) + 1;
        c2i = find(isnan(tempRan(:,2)));
        tempRan(c2i,2) = tempRan(c2i+1,1) - 1;
        rr = [rr;tempRan];
    else
        rr = [rr;rtp]; %#ok<*AGROW>
    end
end
end

function ranges = translateToNextMap(ranges, map)
ranges = ranges(:);
tf = ranges>=map(:,1)' & ranges <=map(:,2)';
ranges = ranges + tf * map(:,3);
ranges = reshape(ranges,[],2);
[~,srtIdx] = sort(ranges(:,1));
ranges = ranges(srtIdx,:);
toRem = find(ranges(2:end,1) == ranges(1:end-1,2)+1);
for idx = numel(toRem):-1:1
    ranges(toRem(idx),2) = ranges(toRem(idx)+1,2);
    ranges(toRem(idx)+1,:) = [];
end
end