%% day22puzzle1 - Daniel Breslan - Advent Of Code 2022
clc
data = readlines("input.txt");
map = char(data(1:find(data == "")-1));
instructions = [data(find(data == "")+1:end).replace(["L","R"],...
    [",-1," ",1,"]).split(",").double; nan];
steps = instructions(1:2:end);
directions = instructions(2:2:end);

facings = [-1 0; 0 1; 1 0; 0 -1]; % U R D L

facingsResult = dictionary(1:4,[3 0 1 2]);

currentDirection = 2;
currentPosition = [1, find(map(1,:) == '.',1)];

for instIdx = 1:numel(steps)
    for idx = 1:steps(instIdx)
        newPosition = currentPosition + facings(currentDirection,:)

        if newPosition(1) == 0 || (map(newPosition(1),newPosition(2)) ...
                == ' ' && currentDirection == 1)
            % U
            currentColumn = map(:,newPosition(2));
            newPosition(1) = find(currentColumn ~= ' ',1,'last');
        elseif newPosition(2) > size(map,2) || ...
                (map(newPosition(1),newPosition(2)) ...
                == ' ' && currentDirection == 2)
            % R
            currentRow = map(newPosition(1),:);
            newPosition(2) = find(currentRow ~= ' ',1);
        elseif newPosition(1) > size(map,1) || ...
                (map(newPosition(1),newPosition(2)) ...
                == ' ' && currentDirection == 3)
            % D
            currentColumn = map(:,newPosition(2));
            newPosition(1) = find(currentColumn ~= ' ',1);
        elseif newPosition(2) == 0 || ...
                (map(newPosition(1),newPosition(2)) ...
                == ' ' && currentDirection == 4)
            % L
            currentRow = map(newPosition(1),:);
            newPosition(2) = find(currentRow ~= ' ',1,'last');
        end

        % is new space valid
        if map(newPosition(1),newPosition(2)) == '#'
            % wall
            break
        elseif map(newPosition(1),newPosition(2)) == '.'
            % open space
            currentPosition = newPosition
        end
    end
    if ~isnan(directions(instIdx))
        currentDirection = currentDirection + directions(instIdx);
    end
    currentDirection(currentDirection == 0) = 4; %#ok<*SAGROW>
    currentDirection(currentDirection == 5) = 1;
end

day22puzzle1result = sum(currentPosition .* [1000 4]) + ...
    facingsResult(currentDirection) %#ok<NOPTS>
