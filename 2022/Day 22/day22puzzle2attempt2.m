%% day22puzzle2 - Daniel Breslan - Advent Of Code 2022
clc
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
        newDirection = currentDirection;
        if newPosition(1) == 0
            % U
            [newPosition, newDirection] = unwrapTheMap(map,newPosition,0,0);
        elseif newPosition(2) > size(map,2)
            % R
            [newPosition, newDirection] = unwrapTheMap(map,newPosition,1,1);
        elseif newPosition(1) > size(map,1)
            % D
            [newPosition, newDirection] = unwrapTheMap(map,newPosition,0,1);
        elseif newPosition(2) == 0
            % L
            [newPosition, newDirection] = unwrapTheMap(map,newPosition,1,0);
        end


        if map(newPosition(1),newPosition(2)) == ' '
            % U
            switch currentDirection
                case 1 % U
                    [newPosition, newDirection] = unwrapTheMap(map,newPosition,0,0);
                case 2 % R
                    [newPosition, newDirection] =  unwrapTheMap(map,newPosition,1,1);
                case 3 % D
                    [newPosition, newDirection] =  unwrapTheMap(map,newPosition,0,1);
                case 4 % L
                    [newPosition, newDirection] =  unwrapTheMap(map,newPosition,1,0);
            end
        end

        % is new space valid
        if map(newPosition(1),newPosition(2)) == '#'
            % wall
            break
        elseif map(newPosition(1),newPosition(2)) == '.'
            % open space
            currentPosition = newPosition;
            currentDirection = newDirection;
        end
    end
    if ~isnan(directions(instIdx))
        % if direction to turn, do it.
        currentDirection = currentDirection + directions(instIdx);
    end

    %     currentPosition
    %wrap the
    currentDirection(currentDirection == 0) = 4; %#ok<*SAGROW>
    currentDirection(currentDirection == 5) = 1;
end

day22puzzle2result = sum(currentPosition .* [1000 4]) + ...
    facingsResult(currentDirection) %#ok<NOPTS>


function [position, direction] = unwrapTheMap(map, position, horizontal, positiveDirection)
sizeDim = size(map,1)/3;

% make edge map - I could automate this...
from = ["1a", "3a", "6a", "1b", "2c", "3c", "2d"];
to   = ["2a", "1d", "4b", "6b", "5c", "5d", "6c"];
edgeMap = dictionary([from to], [to from]);

% make mini map based on map
miniMap = flipud(rot90(map(1:sizeDim:end,1:sizeDim:end)));
miniMap(miniMap ~= ' ') = '123456';
miniMap = miniMap';

% find origin in the mini-map
if positiveDirection
    directionToPrior = -1;
else
    directionToPrior = 1;
end
if horizontal
    priorPosition = [position(1) position(2) + directionToPrior];
else
    priorPosition = [position(1) + directionToPrior position(2)];
end
originSqCoords = ceil(priorPosition / sizeDim);
originSquare = string(miniMap(originSqCoords(1), originSqCoords(2)));

% append direction to origin
if all([horizontal positiveDirection] == [0 0])
    originSquare = originSquare + "a";
elseif all([horizontal positiveDirection] == [0 1])
    originSquare = originSquare + "c";
elseif all([horizontal positiveDirection] == [1 0])
    originSquare = originSquare + "d";
elseif all([horizontal positiveDirection] == [1 1])
    originSquare = originSquare + "b";
end

% find exit
if originSquare.extract(2) == "b" | originSquare.extract(2) == "d" 
        exitPoint = position(1) - (originSqCoords(1) - 1) * sizeDim;
else
        exitPoint = position(2) - (originSqCoords(2) - 1) * sizeDim;
end

end