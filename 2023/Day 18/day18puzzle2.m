%% day18puzzle2 - Daniel Breslan - Advent Of Code 2023
data = readlines("input.txt").split(" ");
l = hex2dec(data(:,3).extractBetween(3,7));
d = data(:,3).extract(8).double + 1;
lu = [0 1;1 0;0 -1;-1 0];
c = zeros(numel(l)+1,2);
for idx = 2:height(c)
    c(idx,:) = c(idx-1,:) + (lu(d(idx-1),:) * l(idx-1));
end
day18puzzle2result = polyarea(c(:,1),c(:,2)) + sum(l)/2 +1 %#ok<NOPTS>