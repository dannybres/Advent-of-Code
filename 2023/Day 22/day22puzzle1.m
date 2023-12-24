%% day22puzzle1 - Daniel Breslan - Advent Of Code 2023
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
day22puzzle1result = sum(r)

function out = overlaps(a,b)
out = max(a(1),b(1)) <= min(a(4),b(4)) && ...
    max(a(2),b(2)) <= min(a(5),b(5));
end