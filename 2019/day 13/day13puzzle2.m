%% day13puzzle2 - Daniel Breslan - Advent Of Code 2019
addpath("../intCodeComputer/")
load("pos.mat")
while 1
    clear paddlePosition
    data = readlines("input.txt").split(",").double();
    data(1) = 2; % play for free
    input = 0;
    numOutputs = Inf;
    idx = 0;
    relativeBase = 0;
    outputs = [];
    positionsToBounceAt = [];
    gameidx = 1;
    while 1
        if gameidx > 1
            numOutputs = 3;
        end
        if exist('paddlePosition','var') && ...
                exist('bestPositionsToBounceAt','var')
            nextTargetPosition = latestPaddlePosition;
            if ~isempty(bestPositionsToBounceAt(find(...
                    bestPositionsToBounceAt(:,1) > gameidx,1),2))
                nextTargetPosition = bestPositionsToBounceAt(...
                    find(bestPositionsToBounceAt(:,1) > gameidx,1),2);
            end
            input = sign(nextTargetPosition - latestPaddlePosition);

        else
            input = 0;
        end
        [newOutputs, data, idx, terminated, relativeBase] = ...
            processIntCodeComputer(data,input,...
            numOutputs,idx, relativeBase);
        outputs = [outputs; newOutputs];
        if terminated
            break
        end
        [drawing, score, paddlePosition, ballReadyToBounce, ...
            numberOfBlocksLeft] = drawCabinet(outputs);
        if ~isnan(ballReadyToBounce)
            positionsToBounceAt = [positionsToBounceAt; gameidx + 2 ...
                ballReadyToBounce];
        end
        if ~isempty(paddlePosition)
            latestPaddlePosition = paddlePosition;
        end
%         drawing
        if terminated
            break
        end
        gameidx = gameidx + 1;
    end

    if numberOfBlocksLeft == 1 && terminated
        break
    end
    bestPositionsToBounceAt = positionsToBounceAt;
end

day13puzzle2result = score %#ok<NOPTS> 

function [drawing, score, paddlePosition, ballReadyToBounce, ...
    numberOfBlocksLeft] = drawCabinet(mapIn)
mapIn = reshape(mapIn,3,[])';
map = mapIn;

scores = map(all(map(:,1:2) == [-1 0],2),:);
score = max(scores(:,3));
map(all(map(:,1:2) == [-1 0],2),:) = [];

map = flipud(map);
[~, w] = unique(map(:,1:2),"rows");

map = map(w,:);
map(:,1:2) = map(:,1:2) + 1 - min(map(:,1:2));
drawing = repmat(' ',max(map(:,1:2)));

idxToDraw = unique(map(:,3));

% 0 is an empty tile. No game object appears in this tile.
% 1 is a wall tile. Walls are indestructible barriers.
% 2 is a block tile. Blocks can be broken by the ball.
% 3 is a horizontal paddle tile. The paddle is indestructible.
% 4 is a ball tile. The ball moves diagonally and bounces off objects.
tiles = ' #=-o';
for idx = 1:numel(idxToDraw)
    mapToDraw = map(map(:,3) == idxToDraw(idx),:);
    drawing(sub2ind(size(drawing),mapToDraw(:,1),mapToDraw(:,2))) = ...
        tiles(idx);
end

drawing = rot90(drawing,3);

ballReadyToBounce = nan;
paddlePosition = map(map(:,3) == 3,1);
if mapToDraw(2) == height(drawing) - 2
    ballReadyToBounce = mapToDraw(1);
end

numberOfBlocksLeft = sum(drawing == '=',"all");
end