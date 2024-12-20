%% day20puzzle1 - Daniel Breslan - Advent Of Code 2024
m = char(readlines("input.txt"));
[r,c] = find(m == 'S');
[tr,tc] = find(m == 'E');
m(m=='S') = '.';
m(m=='E') = '.';

cheatAllowance = 2;

mm = nan(size(m));
mm(m=='#') = inf;

path = nan(round(numel(m)/4),2);
pidx = 0;
for idx = 0:1e6
    mm(r,c) = idx;
    pidx = pidx + 1;
    path(pidx,:) = [r c];
    if all([r c] == [tr tc]), break, end
    for dir = [-1 0;1 0;0 -1;0 1]'
        nr = r + dir(1); nc = c + dir(2);
        if isnan(mm(nr,nc))
            r = nr; c = nc;
            break
        end
    end
end

day20puzzle1result = 0;
path = path(1:pidx,:);
nc = (0:height(path)-1)';
for idx = 1:height(path)
    manhattenDistanceToAll = ...
        abs(path(:,1) - path(idx,1)) + abs(path(:,2) - path(idx,2));
    costSaving = nc(manhattenDistanceToAll <= cheatAllowance) - ...
        (nc(idx) + manhattenDistanceToAll(manhattenDistanceToAll <= cheatAllowance));
    day20puzzle1result = day20puzzle1result + nnz(costSaving >= 100);
end
day20puzzle1result
