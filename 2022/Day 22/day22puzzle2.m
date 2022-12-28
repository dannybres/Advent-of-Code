%% day22puzzle2 - Daniel Breslan - Advent Of Code 2022
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

switch horizontal
    case 1 % horiz
        section = ceil(position(1)/sizeDim);
        switch positiveDirection
            case 1 % R
                switch section
                    case 1 % 1c to 6b flipped
                        exitPoint = position(1);
                        entryPoint = 3 * sizeDim - exitPoint + 1;
                        position = [entryPoint 4 * sizeDim];
                        direction = 4;
                    case 2 % 4a to 6c flipped
                        exitPoint = position(1) - sizeDim;
                        entryPoint = 4 * sizeDim - exitPoint + 1;
                        position = [2 * sizeDim + 1 entryPoint];
                        direction = 3;
                    case 3 % 6b to 1c flipped
                        exitPoint = position(1) - 2 * sizeDim;
                        entryPoint = sizeDim - exitPoint + 1;
                        position = [entryPoint 3 * sizeDim];
                        direction = 4;
                end
            case 0 % L
                switch section
                    case 1 % 1a to 3a flipped
                        1
                    case 2 % 2b to 6a flipped
                        exitPoint = position(1) - sizeDim;
                        entryPoint = 4 * sizeDim - exitPoint + 1;
                        position = [3 * sizeDim entryPoint];
                        direction = 1;
                    case 3 % 5a to 3b flipped
                        exitPoint = position(1) - 2 * sizeDim;
                        entryPoint = 2 * sizeDim - exitPoint + 1;
                        position = [2 * sizeDim entryPoint];
                        direction = 1;
                end
        end
    case 0 % verti
        section = ceil(position(2)/sizeDim);
        switch positiveDirection
            case 1 % D
                switch section
                    case 1 % 2c to 5b flipped
                        exitPoint = position(2);
                        entryPoint = 3 * sizeDim - exitPoint + 1;
                        position = [3 * sizeDim entryPoint];
                        direction = 1;
                    case 2 % 3b to 5a flipped
                        exitPoint = position(2) - sizeDim;
                        entryPoint = 3 * sizeDim - exitPoint + 1;
                        position = [entryPoint 2 * sizeDim + 1];
                        direction = 2;
                    case 3 % 5b to 2c flipped
                        exitPoint = position(2) - 2 * sizeDim;
                        entryPoint = sizeDim - exitPoint + 1;
                        position = [2 * sizeDim entryPoint];
                        direction = 1;
                    case 4 % 6a to 2b flipped
                        1
                end
            case 0 % U
                switch section
                    case 1 % 2a to 1a flipped
                        exitPoint = position(2);
                        entryPoint = exitPoint;
                        position = [entryPoint 2 * sizeDim + 1];
                        direction = 3;
                    case 2 % 3a to 1a flipped
                        exitPoint = position(2) - sizeDim;
                        entryPoint = exitPoint;
                        position = [entryPoint 2 * sizeDim + 1];
                        direction = 2;
                    case 3 % 1b to 2a flipped
                        exitPoint = position(2) - 2 * sizeDim;
                        entryPoint = sizeDim - exitPoint + 1;
                        position = [sizeDim + 1 entryPoint];
                        direction = 3;
                    case 4 % 6c to 4a flipped
                        1
                end
        end
end
%
% if horizontal == 1
%     currentLine = map(position(1),:);
% else
%     currentLine = map(:,position(2));
% end
%
% posIdx = 1;
% whichEnd = 'first';
%
% if horizontal == 1
%     posIdx = 2;
% end
%
% if positiveDirection == 0
%     whichEnd = 'last';
% end
%
% position(posIdx) = find(currentLine ~= ' ',1,whichEnd);
end