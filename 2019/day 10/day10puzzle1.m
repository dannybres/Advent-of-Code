%% day10puzzle1 - Daniel Breslan - Advent Of Code 2019
data = char(readlines("input.txt")) == '#';

[r,c] = ind2sub(size(data),find(data));

asteroids = [r,c];
best = 0;
for idx = 1:height(asteroids)

    searchField = asteroids;
    opt = searchField(idx,:);
    searchField(idx,:) = [];

    diff = searchField - opt;
    diff = complex(diff(:,1),diff(:,2));
    visible = numel(unique(angle(diff)));
    if visible > best
        best = visible;
    end
end
day10puzzle1result = best %#ok<NOPTS> 