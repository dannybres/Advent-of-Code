%% day7puzzle2 - Daniel Breslan - Advent Of Code 2025
data = char(readlines("input.txt"));
clc

water = double(data == 'S');
splitters = data == '^';
while true
% for a = 1:5
    waterDepth = find(any(water,2),1,'last');
    nextDepth = waterDepth + 1;
    if nextDepth > height(water)
        break
    end
    water(nextDepth,:) = water(waterDepth,:);

    for splitterColisionCol = find(water(nextDepth,:) & splitters(nextDepth,:))
        water(nextDepth, splitterColisionCol + [-1 1]) = ...
            water(nextDepth, splitterColisionCol + [-1 1]) + water(waterDepth,splitterColisionCol);
        water(nextDepth,splitterColisionCol) = 0;
    end
end
format longg
day7puzzle2result = sum(water(end,:))
