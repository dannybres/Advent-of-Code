%% day15puzzle1 - Daniel Breslan - Advent Of Code 2019
addpath("../intCodeComputer/")
data = readlines("input.txt").split(",").double;
nextMemoryAddress = 0;
relativeBase = 0;
map = [200 0 1];
map = searchForOxygen(map,data,nextMemoryAddress,relativeBase);

foundFloor = map(map(:,3) ~= 0,1:2);
oxygenSystem = map(map(:,3) == 2,1:2);
dirctions = [-1 0; 1 0; 0 -1; 0 1];

floor = repelem(foundFloor,4,1);
floor = repmat(floor,1,2);
floor(:,3:4) = floor(:,3:4) + repmat(dirctions,height(foundFloor),1);
floor = floor(ismember(floor(:,3:4),foundFloor,"rows"),:);

g = graph(floor(:,1) + "_" + floor(:,2), floor(:,3) + "_" + floor(:,4));

path = shortestpath(g, "200_0", oxygenSystem(1) + ...
    "_" + oxygenSystem(2))';
day15puzzle1result = numel(path)-1 %#ok<NOPTS>

walls = map(map(:,3) == 0,1:2);
floor = map(map(:,3) == 1,1:2);
oxygenSystem = map(map(:,3) == 2,1:2);
close all
plot(walls(:,1),walls(:,2),'k.', MarkerSize=15)
hold on
plot(floor(:,1),floor(:,2),'bx', MarkerSize=1)
grid on
pathco = path.split("_").double;
plot(pathco(:,1),pathco(:,2), Color="red", LineWidth=3)
plot(200,0,'pentagram',MarkerSize=10,MarkerFaceColor="green")
plot(oxygenSystem(:,1),oxygenSystem(:,2),'ro',MarkerSize=8,...
    MarkerFaceColor="red")

function [map, data,nextMemoryAddress,relativeBase] = searchForOxygen(...
    map,data,nextMemoryAddress,relativeBase)
% north (1), south (2), west (3), and east (4)
dirctions = [-1 0; 1 0; 0 -1; 0 1];
startingPosition = map(end,:);
preData = data;
preNMA = nextMemoryAddress;
preRB = relativeBase;
for input = 1:4
    squareToInvestigate = startingPosition(1:2) + dirctions(input,:);
    if any(all(map(:,1:2) == squareToInvestigate,2))
        continue
    end
    [nextSquare, data, nextMemoryAddress, terminated, relativeBase] = ...
        processIntCodeComputer(preData,input,...
        1,preNMA, preRB);
    if terminated
        error("terminated")
    end
    map = [map; squareToInvestigate nextSquare];
    if nextSquare == 1 || nextSquare == 2
        map = searchForOxygen(map,data,nextMemoryAddress,relativeBase);
    end
end

end