%% day4puzzle2 - Daniel Breslan - Advent Of Code 2024
data = char(padarray(double(char(readlines("input.txt"))),[3 3],double(' ')));
[r,c] = find(data == 'X');
day4puzzle1result = 0;
for idx = 1:numel(r)
    for dir = [-1 -1;-1 0;-1 1;0 1;1 1;1 0;1 -1;0 -1]'
        lidx = sub2ind(size(data),r(idx) + dir(1) * (0:3),c(idx) + dir(2) * (0:3));
        day4puzzle1result = day4puzzle1result + double(all(data(lidx) == 'XMAS'));
    end
end
day4puzzle1result

[r,c] = find(data == 'A');
day4puzzle2result = 0;
for idx = 1:numel(r)
    idxs = [r(idx) + [-1 1 -1  1];...
            c(idx) + [-1 1  1 -1]];
    lidx = sub2ind(size(data),idxs(1,:),idxs(2,:));
    indicator = data(lidx) == ['M';'S'];
    lhs = indicator(:,1:2);
    rhs = indicator(:,3:4);
    day4puzzle2result = day4puzzle2result + double(all([sum(lhs) sum(lhs,2)' sum(rhs) sum(rhs,2)']));
end

day4puzzle2result