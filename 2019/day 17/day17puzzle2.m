%% day17puzzle2 - Daniel Breslan - Advent Of Code 2019
addpath("../intCodeComputer/")
data = readlines("inputDemo.txt").split(",").double();
data(1) = 2; % activate it

% draw map of scaff
[outputs, data, nextMemoryAddress, terminated, relativeBase] = ...
    processIntCodeComputer(data,[],...
    Inf,0, 0);
out = outputs(1:1837);
sizeOfRow = find(out == 10,1) -1;
out(out == 10) = [];
out = reshape(out,sizeOfRow,[]);
map = repmat(' ',size(out));
map(out == 35) = '#';
map = map';
out = out';
[r,c] = ind2sub(size(map),find(out == 94));
map(out == 94) = '#';

% find list of path though scaff
gauge = zeros(3);
gauge([2 4 5 6 8]) = 1;
intersects = conv2(map == '#',gauge,"same") == 5;
list = [r c 2]; % is 2 problem specific? Always starts facing up?
for idx = 1:sum(map == '#','all') + sum(intersects,'all') - 1
    [map,list] = findNextSquare(map,list);
end

% turn list into commands
turnsLogic = diff(list(:,3));
turnsLogic = turnsLogic(turnsLogic ~= 0);
turnsLogic = turnsLogic == -1 | turnsLogic == 3;
turns = repmat("R",numel(turnsLogic),1);
turns(turnsLogic) = "L";
distList = diff(list(:,1:2)) ~= 0;
bcc = bwconncomp(distList,4);
[place, sizeOf]  = cellfun(@processBWW,bcc.PixelIdxList);
[r,~] = ind2sub(size(distList),place);
[~,idx] = sort(r);
distances = sizeOf(idx)';

instructions = strings(numel(turns) + numel(distances),1);
instructions(1:2:end) = turns;
instructions(2:2:end) = distances;

% Find the 
commands = turns + "," + distances;
orginalCommand = commands;
routinesLen = zeros(2,1);
routines = strings(3,1);
locationsOfRoutine = cell(3,1);
for ridx = 1:2
commandsCandiateForRoutine = commands(cumsum(commands.strlength) < 19);
repeats = zeros(numel(commandsCandiateForRoutine) - 1,1);
for idx = 2:numel(commandsCandiateForRoutine)
    possiblerou = commandsCandiateForRoutine(1:idx);
    checker = repmat(commands,1,idx);
    for cidx = 2:size(checker,2)
        checker(:,cidx) = circshift(checker(:,cidx),-cidx+1,1);
    end
    repeats(idx-1) = sum(ismember(checker, possiblerou','rows'));
end
routineIdx = 1 + find(repeats == max(repeats),1,"last");
routine = commandsCandiateForRoutine(1:routineIdx);
routines(ridx) = commandsCandiateForRoutine(1:routineIdx).join(",");
routinesLen(ridx) = numel(routine);
checker = repmat(commands,1,routineIdx);
for cidx = 2:size(checker,2)
    checker(:,cidx) = circshift(checker(:,cidx),-cidx+1,1);
end
originalChecker = repmat(orginalCommand,1,routineIdx);
for cidx = 2:size(originalChecker,2)
    originalChecker(:,cidx) = circshift(originalChecker(:,cidx),-cidx+1,1);
end
locationsOfRoutine{ridx} = find(ismember(originalChecker, routine',...
    'rows'))';
toRemove = find(ismember(checker, routine','rows')) + (0:routineIdx-1);
commands(toRemove(:)) = [];
end
leftForC = orginalCommand;
for idx = 1:2
    usedup = locationsOfRoutine{idx}' + (0:routinesLen(idx)-1);
    leftForC(usedup(:)) = "";
end
rouC = bwconncomp(leftForC ~= "");
[place, sizeOf] = cellfun(@processBWW, rouC.PixelIdxList);
locationsOfRoutine{3} = place;
routines(3) = orginalCommand(place(find(min(sizeOf) == sizeOf,1,...
    "first")):(place(find(min(sizeOf) == sizeOf,1,"first")) + ...
    sizeOf(find(min(sizeOf) == sizeOf,1,"first"))-1)).join(",");

locations = horzcat(locationsOfRoutine{:});
[~, idx] = sort(locations);
routineOrder = [repmat("A",1,numel(locationsOfRoutine{1})) ...
    repmat("B",1,numel(locationsOfRoutine{2})) repmat("C",1,...
    numel(locationsOfRoutine{3}))];
routineOrder = char(routineOrder(idx).join(","));

% Program the robot
[~, data, nextMemoryAddress, ~, relativeBase] = ...
    processIntCodeComputer(data,[double(routineOrder) 10],...
    Inf,nextMemoryAddress, relativeBase);
for idx = 1:3
[~, data, nextMemoryAddress, ~, relativeBase] = ...
    processIntCodeComputer(data,[double(char(routines(idx))) 10],...
    Inf,nextMemoryAddress, relativeBase);
end

[outputs, data, nextMemoryAddress, ~, relativeBase] = ...
    processIntCodeComputer(data,[double('n'), 10],...
    Inf,nextMemoryAddress, relativeBase);

day17puzzle2result = outputs(end) %#ok<NOPTS>

%% Helper Functions
function [place, sizeOf] = processBWW(in)
% helper for bwcompcon outputs
place = in(1);
sizeOf = numel(in);
end

function [map,list] = findNextSquare(map, list)
% help find next square
currentPosition = list(end,1:2);
currentDirection = list(end,3);
allDirections = [0 -1;-1 0;0 1;1 0];
canditateScaff = currentPosition + allDirections(currentDirection,:);
newScaff = canditateScaff;
newDirection = currentDirection;
if any(canditateScaff < 1) || any(canditateScaff > size(map))
    needToTurn = true;
else
    needToTurn = map(canditateScaff(1),canditateScaff(2)) == ' ';
end

if needToTurn
    % need to turn!!!
    allOptions = currentPosition + allDirections;
    allOptions = allOptions(~any(allOptions < 1,2),:);
    allOptions = allOptions(~any(allOptions > size(map),2),:);
    allOptions = allOptions(~ismember(allOptions,list(:,1:2),'rows'),:);
    newScaff = allOptions(map(sub2ind(size(map), allOptions(:,1),...
        allOptions(:,2))) == '#',:);
    newDirection = find(all(newScaff - currentPosition == allDirections,2));
end
list = [list; newScaff newDirection];
end