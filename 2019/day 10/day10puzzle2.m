%% day10puzzle2 - Daniel Breslan - Advent Of Code 2019
data = char(readlines("inputDemo.txt")) == '#';

[r,c] = ind2sub(size(data),find(data));

asteroids = [r,c];
best = 0;
bestIdx = 0;
for idx = 1:height(asteroids)

    searchField = asteroids;
    opt = searchField(idx,:);
    searchField(idx,:) = [];

    diff = searchField - opt;
    diff = complex(diff(:,1),diff(:,2));
    visible = numel(unique(angle(diff)));
    if visible > best
        best = visible;
        bestIdx = idx;
    end
end

coord = asteroids(bestIdx,:)';

coord = [4 9];

map = repmat(' ',size(data));
map(sub2ind(size(data),r,c)) = '.';
map(coord(1),coord(2)) = '#';

allAsteroids = asteroids;
allAsteroids(bestIdx,:) = [];

differences = coord - allAsteroids;
differences = complex(differences(:,1),differences(:,2));

remainingAsteroids = table(angle(differences), abs(differences), allAsteroids, VariableNames = ["angle","dist","coo"])
remainingAsteroids.angle(remainingAsteroids.angle < 0) = 2*pi + remainingAsteroids.angle(remainingAsteroids.angle < 0);
remainingAsteroids.angle = 2*pi - remainingAsteroids.angle;
remainingAsteroids.angle(remainingAsteroids.angle == 2*pi) = 0;

allAsteroids = sortrows(remainingAsteroids,["angle","dist"])

% allAsteroids = [allAsteroids nan(height(allAsteroids),1)]




day10puzzle2result = best %#ok<NOPTS> 