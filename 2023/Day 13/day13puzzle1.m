%% day13puzzle1 - Daniel Breslan - Advent Of Code 2023
data = [""; readlines("input.txt"); ""];
splits = find(data == "");

r = nan(numel(splits)-1,2);
for idx = 1:numel(splits)-1
    m = char(data(splits(idx)+1:splits(idx+1)-1));
    r(idx,:) = [0 processMap(m)];
    if isnan(r(idx,2))
        r(idx,:) = [1 processMap(m')];
    end
end
r(r(:,1) == 1,2) = r(r(:,1) == 1,2) * 100;
day13puzzle1result = sum(r(:,2)) %#ok<NOPTS>


function aidx = processMap(m)
w = width(m);
afterLine = 1:w-1;
for aidx = 1:numel(afterLine)
    a = afterLine(aidx);
    widthOfThem = min(a,w-a);
    lhs = m(:,a-widthOfThem+1:a);
    rhs = fliplr(m(:,a+1:a+widthOfThem));
    if lhs == rhs
        return
    end
end
aidx = nan;
end