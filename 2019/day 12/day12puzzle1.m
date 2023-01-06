%% day12puzzle1 - Daniel Breslan - Advent Of Code 2019
data = readlines("input.txt").erase(["<x="," y="," z=",">"])...
    .split(",").double();
data = [data zeros(height(data),3)];
for idx = 1:1e3
posMat = zeros([size(data(:,1:3)) height(data(:,1:3))]);
for pmidx = 1:height(posMat)
    posMat(:,:,pmidx) = circshift(data(:,1:3),pmidx-1);
end

data(:,4:end) = data(:,4:end) + sum(posMat(:,:,2:end) > posMat(:,:,1),3)...
    - sum(posMat(:,:,2:end) < posMat(:,:,1),3);
data(:,1:3) = data(:,1:3) + data(:,4:end);
end

day12puzzle1result = sum(sum(abs(data(:,1:3)),2) .* ...
    sum(abs(data(:,4:end)),2))