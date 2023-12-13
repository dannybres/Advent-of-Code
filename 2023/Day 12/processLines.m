function n = processLines(springs,counts)
n = 0;
if sum(any(springs == ('?#')')) < sum(counts)
    return
end

persistent d
if isempty(d)
    d = dictionary('1',0);
end
dk = [springs char(counts')];
if isKey(d,dk)
    n = d(dk);
    return
end
if numel(counts) == 1
    subStr = springs;
else
    subStr = springs(1:end - sum(counts(2:end)) - (numel(counts) - 2));
end

if max(sum(cumsum(subStr == '.')' == 1:sum(subStr == '.')) - 1) < max(counts)
    return
end

placesItCanBe = any(subStr == ('?#')');
placesItCanBreak = any(subStr == ('?.')');
if ~sum(placesItCanBe)
    return
end

ranges = (0:numel(subStr) - counts(1) - 1)' + (1:counts(1));
h = size(ranges,1);

placesItCanBreakAfter = placesItCanBreak(ranges(:,end)+1)';

beforenum = ranges(:,1)-1;
placesItCanBreakBefore = false(h,1);
placesItCanBreakBefore(beforenum == 0) = true;
if any(beforenum > 0)
    placesItCanBreakBefore(beforenum ~= 0) = ...
        placesItCanBreak(beforenum(beforenum ~= 0));
end

noHashPrior = true(h,1);
firstHashIdx = find(subStr(1:end-1) == '#',1);
if ~isempty(firstHashIdx)
    noHashPrior = ranges(:,1) <= firstHashIdx;
end

canAllBeSprings = all(reshape(placesItCanBe(ranges),...
    h,[]),2);

startingPositions = noHashPrior & canAllBeSprings & ...
    placesItCanBreakAfter & placesItCanBreakBefore;
if ~any(startingPositions)
    return
end
if numel(counts) == 1 & any(subStr == '#')
    startingPositions(startingPositions) = ...
        sum(reshape(subStr(ranges(startingPositions,:)),...
        sum(startingPositions),[]) == '#',2) == sum(subStr == '#');
end
startingPositions = find(startingPositions);
if numel(counts) == 1
    n = numel(startingPositions);
    return
end

for idx = startingPositions'
    n = n + processLines(springs(idx + counts(1) + 1:end),counts(2:end));
end
d(dk) = n;
end

