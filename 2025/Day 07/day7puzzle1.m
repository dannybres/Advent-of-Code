%% day7puzzle1 - Daniel Breslan - Advent Of Code 2025
clc
data = char(readlines("input.txt"));

water = data == 'S';
splitters = data == '^';
day7puzzle1result = 0;
while true
    waterDepth = find(any(water,2),1,'last');
    nextDepth = waterDepth + 1;
    if nextDepth > height(water)
        break
    end
    water(nextDepth,:) = water(waterDepth,:);

    if (any(water(nextDepth,:) & splitters(nextDepth,:)))
        splitterColisions = find(water(nextDepth,:) & splitters(nextDepth,:))';
        water(nextDepth,splitterColisions) = false;
        water(nextDepth, splitterColisions + [-1 1]) = true;
        day7puzzle1result = day7puzzle1result + numel(splitterColisions);
    end
end
day7puzzle1result