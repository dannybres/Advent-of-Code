%% day18puzzle1 - Daniel Breslan - Advent Of Code 2023
data = readlines("input.txt").split(" ");
d = data(:,1);
l = data(:,2).double;
lu = dictionary(["U";"D";"L";"R"],{[-1 0];[1 0];[0 -1];[0 1]});
c = zeros(numel(l)+1,2);
for idx = 2:height(c)
    c(idx,:) = c(idx-1,:) + (lu{d(idx-1)} * l(idx-1));
end
% close all
% plot(c(:,1),c(:,2))
day18puzzle1result = polyarea(c(:,1),c(:,2)) + sum(l)/2 +1 %#ok<NOPTS>