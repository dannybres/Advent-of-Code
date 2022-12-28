%% day22puzzle1 - Daniel Breslan - Advent Of Code 2022
data = readlines("inputDemo.txt");
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
        newPosition = currentPosition + facings(currentDirection,:);

        if newPosition(1) == 0
            % U
            newPosition = unwrapTheMap(map,newPosition,2,1);
        elseif newPosition(2) > size(map,2)
            % R
            newPosition = unwrapTheMap(map,newPosition,1,0);
        elseif newPosition(1) > size(map,1)
            % D
            newPosition = unwrapTheMap(map,newPosition,2,0);
        elseif newPosition(2) == 0
            % L
            newPosition = unwrapTheMap(map,newPosition,1,1);
        end


        if map(newPosition(1),newPosition(2)) == ' '
            % U
            switch currentDirection
                case 1 % U
                    newPosition = unwrapTheMap(map,newPosition,2,1);
                case 2 % R
                    newPosition = unwrapTheMap(map,newPosition,1,0);
                case 3 % D
                    newPosition = unwrapTheMap(map,newPosition,2,0);
                case 4 % L
                    newPosition = unwrapTheMap(map,newPosition,1,1);
            end
        end

        % is new space valid
        if map(newPosition(1),newPosition(2)) == '#'
            % wall
            break
        elseif map(newPosition(1),newPosition(2)) == '.'
            % open space
            currentPosition = newPosition;
        end
    end
    if ~isnan(directions(instIdx))
        % if direction to turn, do it.
        currentDirection = currentDirection + directions(instIdx);
    end

    %wrap the 
    currentDirection(currentDirection == 0) = 4; %#ok<*SAGROW>
    currentDirection(currentDirection == 5) = 1;
end

day22puzzle1result = sum(currentPosition .* [1000 4]) + ...
    facingsResult(currentDirection) %#ok<NOPTS>


function position = unwrapTheMap(map, position, axis, direction)
if axis == 1
    currentLine = map(position(1),:);
else
    currentLine = map(:,position(2));
end

posIdx = 1;
whichEnd = 'first';

if axis == 1
    posIdx = 2;
end

if direction == 1
    whichEnd = 'last';
end

position(posIdx) = find(currentLine ~= ' ',1,whichEnd);
end