%% day17puzzle1 - Daniel Breslan - Advent Of Code 2022
clear
clc
gusts = readlines("input.txt").replace(["<",">"],["-1,","1,"]).split(",").double';
gusts(end) = [];

atRest = [zeros(7,1) (1:7)'];

pieces = {[1 3;1 4;1 5; 1 6],... % -
    [1 4;2 3;2 4;2 5;3 4],... % +
    [1 3;1 4;1 5;2 5;3 5],... % L - rev
    [1 3;2 3;3 3;4 3],... % |
    [1 3;1 4;2 3;2 4]}; % #
% y x isUpper isLower

gustIdx = 1;
blocks = 10e3;
finalLocatsTokeep = 15;
height = nan(blocks,1);
startingPoint = nan(blocks,2 + 2*(finalLocatsTokeep+1));
for nextPieceIdx = 1:blocks
    NextPieceToFall = mod(nextPieceIdx,numel(pieces));
    NextPieceToFall(NextPieceToFall == 0) = numel(pieces);

    if nextPieceIdx > 5
        gustIdx = mod(gustIdx,numel(gusts));
        gustIdx(gustIdx == 0) = numel(gusts);

        finalPieces = atRest(end-15:end,:);
        finalPieces(:,1) = finalPieces(:,1) - max(finalPieces(:,1));
        startingPoint(nextPieceIdx,:) = [NextPieceToFall, gustIdx, finalPieces(:)'];
    end

    nextPiece = pieces{NextPieceToFall}(:,1:2) + [3 + max(atRest(:,1)) 0];

    for idx = 1:3
        [nextPiece, gustIdx] = movePieceSide(nextPiece, atRest,gusts, gustIdx);
        nextPiece = movePieceDown(nextPiece);
    end
    [nextPiece, gustIdx] = movePieceSide(nextPiece, atRest,gusts, gustIdx);

    while ~isAtRest(nextPiece,atRest)
        nextPiece = movePieceDown(nextPiece);
        [nextPiece, gustIdx] = movePieceSide(nextPiece, atRest,gusts, gustIdx);
    end

    atRest = [atRest; nextPiece];
    height(nextPieceIdx) = max(atRest(:,1));
end

cycleSize = 1735;
cycleHeight = 2695;

blocksNeeded = 1000000000000;
 
cycles = floor(1000000000000/cycleSize);

cycles = cycles - 1;

day17puzzle1result = cycles * cycleHeight + height(blocksNeeded ...
    - cycles * cycleSize)

% too high = 1553314121033

function [piece, gustIdx] = movePieceSide(piece, atRest, gusts, gustIdx)
gustIdx = mod(gustIdx,numel(gusts));
gustIdx(gustIdx == 0) = numel(gusts);
direction = gusts(gustIdx);
gustIdx = gustIdx + 1;
potentialPieceLocation = piece;
potentialPieceLocation(:,2) = potentialPieceLocation(:,2) + direction;

if any(potentialPieceLocation(:,2) < 1)
    return
end

if any(potentialPieceLocation(:,2) > 7)
    return
end

if any(squeeze(all(potentialPieceLocation == ...
        reshape(atRest',1,2,[]),2)),'all')
    return
end

piece = potentialPieceLocation;
end

function piece = movePieceDown(piece)
piece(:,1) = piece(:,1) - 1;
end

function atRest = isAtRest(piece,atRest)
piece(:,1) = piece(:,1) - 1;
atRest = any(squeeze(all(piece == reshape(atRest',1,2,[]),2)),'all');
end