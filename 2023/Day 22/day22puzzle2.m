%% day22puzzle2 - Daniel Breslan - Advent Of Code 2023
clc
data = readlines("input.txt").extract(digitsPattern).double;
[~,idx] = sort(data(:,3));
data = data(idx,:);

for idx = 1:size(data,1)
    maxZ = 1;
    for oidx = 1:idx-1
        if overlaps(data(idx,:),data(oidx,:))
            maxZ = max(maxZ, data(oidx,6)+1);
        end
    end
    data(idx,6) = data(idx,6) - data(idx,3) + maxZ;
    data(idx,3) = maxZ;
end
[~,idx] = sort(data(:,3));
data = data(idx,:);

iSupport = cell(size(data,1),1);
supportsMe = iSupport;
for idx = 1:size(data,1)
    for oidx = 1:idx-1
        if overlaps(data(idx,:),data(oidx,:)) && ...
                data(idx,3) - 1 == data(oidx,6)
            supportsMe{idx} = [supportsMe{idx} oidx];
            iSupport{oidx} = [iSupport{oidx} idx];
        end
    end
end
r = false(size(data,1),1);
for idx = 1:size(data,1)
    r(idx) = all(cellfun(@numel,supportsMe(iSupport{idx})) > 1);
end

willFall = find(~r);

t = 0;
for idx = 1:numel(willFall)
    fell = willFall(idx);
    couldFall = iSupport{willFall(idx)};
    toFall = couldFall(cellfun(@numel,supportsMe(couldFall)) == 1);
    while ~isempty(toFall)
        fall = toFall(1);
        toFall(1) = [];
        fell = [fell fall]; %#ok<*AGROW>
        supports = iSupport{fall};
        supports(ismember(supports,fell)) = [];
        for isdx = iSupport{fall}
            if all(ismember(supportsMe{isdx},fell))
                toFall = [toFall isdx];
            end
        end
    end
    t = t + numel(fell) - 1;
end

% 43056 - right
% 44621 - too high
% 119441 - too high
day22puzzle2result = t

function out = overlaps(a,b)
out = max(a(1),b(1)) <= min(a(4),b(4)) && ...
    max(a(2),b(2)) <= min(a(5),b(5));
end