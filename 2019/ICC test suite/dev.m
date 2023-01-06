addpath("../intCodeComputer/")

%% day 2
data = readlines("d2.txt").split(",").double();
data(2:3) = [12 2];
[~, data] = processIntCodeComputer(data); 
d2p1 = data(0) == 5110675;

data = readlines("d2.txt").split(",").double();
data(2:3) = [48 47];
[~, data] = processIntCodeComputer(data,1); 
d2p2 = 19690720 == data(0); 

%% day 5
data = readlines("d5.txt").split(",").double();
output = processIntCodeComputer(data,1);
d5p1 = all(output == [zeros(numel(output)-1,1); 6745903]);

data = readlines("d5.txt").split(",").double();
output = processIntCodeComputer(data,5);
d5p2 = 9168267 == output;

%% day 7
data = split(readlines("d7.txt"),",").double();
options = perms(0:4);
maxThrust = 0;
for optIdx = 1:height(options)
    out = 0;
    for idx = options(optIdx,:)
        out = processIntCodeComputer(data,[idx out]);
    end
    if out > maxThrust
        maxThrust = out;
    end
end
d7p1 = maxThrust == 338603; %#ok<NOPTS>

data = split(readlines("d7.txt"),",").double();
options = perms(5:9);
maxThrust = 0;

for optIdx = 1:height(options)
    outputs = zeros(5,1);
    terminated = false(5,1);
    dataInProcess = repmat({data},1,5);
    idxInProcess = zeros(5,1);
    for map = 1:10
        for ampNum = 1:5
            previousAmp = ampNum - 1;
            if previousAmp == 0
                previousAmp = 5;
            end
            input = [options(optIdx,ampNum) outputs(previousAmp)];
            if map ~= 1
                input = input(2);
            end
            [outputs(ampNum), dataInProcess{ampNum}, idxInProcess(ampNum),...
                terminated(ampNum)] = processIntCodeComputer(dataInProcess{ampNum},...
                input,1,idxInProcess(ampNum));
        end
        if all(terminated)
            break
        end
        priorOutput = outputs;
    end

    if priorOutput(end) > maxThrust
        maxThrust = priorOutput(end);
    end
end

day7puzzle2result = maxThrust; %#ok<NOPTS> 

d7p2 = day7puzzle2result == 63103596;

%% day 9
data = readlines("d9.txt").split(",").double();
output = processIntCodeComputer(data,1);
d9p1 = 3335138414 == output;

data = readlines("d9.txt").split(",").double();
output = processIntCodeComputer(data,2);
d9p2 = 49122 == output;

%% day 11
data = readlines("d11.txt").split(",").double();
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
d11p1 = 2392 == height(unique(map(:,1:2),'rows')) %#ok<NOPTS> 



data = readlines("d11.txt").split(",").double();
idx = 0;

map = [0 0 1];
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
map = map;
map = flipud(map);
[~, w] = unique(map(:,1:2),"rows");

submap = map(w,:);
submap(:,1:2) = submap(:,1:2) + 1 - min(submap(:,1:2));
drawing = repmat(' ',max(submap(:,1:2)));
whiteDots = submap(submap(:,3) == 1,1:2);
drawing(sub2ind(size(drawing),whiteDots(:,1),whiteDots(:,2))) = '#';
d11p2 = all(drawing(4,:) == ' #    # ## #  # #  # #    #    #  # #      ');

%% results
testsuccess = [d2p1 d2p2; d5p1 d5p2; d7p1 d7p2; d9p1 d9p2; d11p1 d11p2] %#ok<NOPTS> 