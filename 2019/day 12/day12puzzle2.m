%% day12puzzle2 - Daniel Breslan - Advent Of Code 2019
data = readlines("input.txt").erase(["<x="," y="," z=",">"])...
    .split(",").double();
data = [data zeros(height(data),3)];
xt = nan;
yt = nan;
zt = nan;
idx = 1;
while isnan(xt) || isnan(yt) || isnan(zt)
posMat = zeros([size(data(:,1:3)) height(data(:,1:3))]);
for pmidx = 1:height(posMat)
    posMat(:,:,pmidx) = circshift(data(:,1:3),pmidx-1);
end

data(:,4:end) = data(:,4:end) + sum(posMat(:,:,2:end) > posMat(:,:,1),3)...
    - sum(posMat(:,:,2:end) < posMat(:,:,1),3);
data(:,1:3) = data(:,1:3) + data(:,4:end);
if all(data(:,4) == [0;0;0;0]) && isnan(xt)
    xt = idx;
end
if all(data(:,5) == [0;0;0;0]) && isnan(yt)
    yt = idx;
end
if all(data(:,6) == [0;0;0;0]) && isnan(zt)
    zt = idx;
end
idx = idx + 1;
end

day12puzzle1result = lcm(lcm(xt,yt),zt) * 2 %#ok<NOPTS> % x2 as this is 
% when it rests after half a cycle