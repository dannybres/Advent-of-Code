%% day11puzzle1 - Daniel Breslan - Advent Of Code 2019
addpath("../intCodeComputer/")
data = readlines("input.txt").split(",").double();
idx = 0;

map = [0 0 0];
currentDirection = 1; % (turning right) up > right > down > left
directions = [-1 0;...
    0 1;...
    1 0;...
    0 -1];
relativeBase = 0;

% output(1)
% 0 means to paint the panel black
% 1 means to paint the panel white.
% output(2)
% 0 means it should turn left 90 degrees
% 1 means it should turn right 90 degrees.

while 1
    [outputs, data, idx, terminated, relativeBase] = ...
        processIntCodeComputer(data,map(end),2,idx, relativeBase);
    if terminated
        break
    end
    colourToPaint = outputs(1);
    map(end) = colourToPaint;

    directionToTurn = outputs(2);
    directionToTurn(directionToTurn == 0) = -1;
    currentDirection = currentDirection + directionToTurn;
    currentDirection(currentDirection == 0) = 4;
    currentDirection(currentDirection == 5) = 1;
    newLocation = map(end,1:2) + directions(currentDirection,:);
    newLocationColour = 0;
    priorVisits = map(all(map(:,1:2) == newLocation,2),:);
    if ~isempty(priorVisits)
        newLocationColour = priorVisits(end);
    end
    map = [map; [newLocation newLocationColour]]; %#ok<AGROW> 

end
day11puzzle1result = height(unique(map(:,1:2),'rows')) %#ok<NOPTS> 