%% day22puzzle1 - Daniel Breslan - Advent Of Code 2022
clc
data = readlines("inputDemo.txt");
map = char(data(1:find(data == "")-1))
instructions = data(find(data == "")+1:end).replace(["L","R"],...
    ["L," "R,"]).split(",");

instructions(end) = instructions(end) + " ";

directions = instructions.extractAfter(strlength(...
    instructions)-1);
directions = directions.replace(["L","R"],["-1","1"]).double;

steps = instructions.extractBefore(strlength(instructions)).double();

facings = [-1 0; 0 1; 1 0; 0 -1]; % U R D L 

currentDirection = 2;
currentPosition = [1, find(map(1,:) == '.',1)];

for instIdx = 1:2%:numel(steps)
	for idx = 1:steps(instIdx)
        newPosition = currentPosition + facings(currentDirection,:);
        if strcmp(map(newPosition(1),newPosition(2)),'.')
            % open space
            currentPosition = newPosition
        end
    end
    currentDirection = currentDirection + directions(instIdx)
end

day22puzzle1result = 0;
