%% day10puzzle2 - Daniel Breslan - Advent Of Code 2019
data = char(readlines("input.txt")) == '#';

% find laser location
[r,c] = ind2sub(size(data),find(data));
asteroids = [r,c];
best = 0;
bestIdx = 0;
for idx = 1:height(asteroids) % loop all asteroids
    searchField = asteroids;
    opt = searchField(idx,:); % select one
    searchField(idx,:) = []; % remove it
    diff = searchField - opt; % get distance
    diff = complex(diff(:,1),diff(:,2)); % complex vector from 1 to all
    visible = numel(unique(angle(diff))); % find number of unique angles
    if visible > best
        best = visible;
        bestIdx = idx;
    end
end
coord = asteroids(bestIdx,:); % laser location

allAsteroids = asteroids; % set up a table of all angles, dist, coord
allAsteroids(bestIdx,:) = [];
differences = coord - allAsteroids;
differences = complex(differences(:,1),differences(:,2));
allAsteroids = table(angle(differences), abs(differences), allAsteroids,...
    nan(height(allAsteroids),1), ...
    VariableNames = ["angle","dist","coo","order"]); % add order of destr
allAsteroids.angle(allAsteroids.angle < 0) = 2*pi + allAsteroids.angle(...
    allAsteroids.angle < 0);
allAsteroids.angle = 2*pi - allAsteroids.angle;
allAsteroids.angle(allAsteroids.angle == 2*pi) = 0; % cleanse data
allAsteroids = sortrows(allAsteroids,["angle","dist"]); % sort it

while any(isnan(allAsteroids.order))
    availableToDestroy = allAsteroids(isnan(allAsteroids.order),:);
    canBeDestroyedThisLoop = [true; availableToDestroy.angle(2:end) ~= ...
        availableToDestroy.angle(1:end-1)]; % not the same as prior angle
    % can be destroyed this loop.
    availableToDestroy.order(canBeDestroyedThisLoop) = ...
        1:sum(canBeDestroyedThisLoop);
    if ~isnan(max(allAsteroids.order))
        availableToDestroy.order = availableToDestroy.order + ...
            max(allAsteroids.order);
    end
    allAsteroids(isnan(allAsteroids.order),:) = availableToDestroy;
end
rock200 = fliplr(allAsteroids.coo(allAsteroids.order == 200,:))-1;
day10puzzle2result = sum(rock200 .* [100 1]) %#ok<NOPTS>