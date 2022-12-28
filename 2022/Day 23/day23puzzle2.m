%% day23puzzle2 - Daniel Breslan - Advent Of Code 2022
data = char(readlines("input.txt")) == '#';
[elvesr, elevesc] = ind2sub(size(data),find(data));
elves = [elvesr elevesc];
lastElves = elves * 0;
directions(:,:,:,1) = reshape([-1 -1 -1; -1:1],1,2,[]);
directions(:,:,:,2) = reshape([1 1 1; -1:1],1,2,[]);
directions(:,:,:,3) = reshape([-1:1; -1 -1 -1],1,2,[]);
directions(:,:,:,4) = reshape([-1:1; 1 1 1],1,2,[]);

allDirs = [repelem((-1:1)',3,1) repmat((-1:1)',3,1)];
allDirs(ismember(allDirs,[0 0],'rows'),:) = [];
allDirs = reshape(allDirs',1,2,[]);

dirModder = 0;

% for idx = 1:10
n = 1;
while 1
    proposedMoves = nan(size(elves));

    finishedElf = all(reshape(~ismember(reshape(pagetranspose(elves + ...
        allDirs),2,[])',elves,'rows'), [],8),2);

    for idx = 1:size(directions,4)

        dirIdx = mod(idx + dirModder,4);
        dirIdx(dirIdx == 0) = 4;
        direction = directions(:,:,:,dirIdx);
        options = elves(~finishedElf,:) + direction;

        options = options(isnan(proposedMoves(~finishedElf,1)),:,:);
        
        potentialElves = find(all(isnan(proposedMoves),2) & ~finishedElf);

        canMoveInDirection = all(reshape(~ismember(reshape( ...
            pagetranspose(options),2,[])',elves,'rows'), [],3),2);

        elvesToUpdate = potentialElves(canMoveInDirection);
        
        movesToAdd = options(canMoveInDirection,:,2);

        proposedMoves(elvesToUpdate,:) = movesToAdd;



        if all(~isnan(proposedMoves),'all')
            break
        end
    end

    proposedMovesId = 2 * proposedMoves(:,1) * max(proposedMoves,[], ...
        "all") + proposedMoves(:,2);

    elvesCanMove = sum(proposedMovesId == proposedMovesId',2) == 1;
    elves(elvesCanMove & ~finishedElf,:) = proposedMoves(elvesCanMove ...
        & ~finishedElf,:);
    dirModder = dirModder + 1;

    if all(lastElves == elves,'all')
        break
    end
    n = n + 1;
    lastElves = elves;

end

day23puzzle2result = n %#ok<NOPTS> 