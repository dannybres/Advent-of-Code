%% day24puzzle1 - Daniel Breslan - Advent Of Code 2022
data = char(readlines("input.txt"));
map = data(2:end-1,2:end-1);

bliz = nan(size(map,1),size(map,2),4,numel(map));
bliz(:,:,1,1) = map == '<';
bliz(:,:,2,1) = map == '>';
bliz(:,:,3,1) = map == '^';
bliz(:,:,4,1) = map == 'v';

for idx = 2:size(bliz,4)
    bliz(:,:,1,idx) = circshift(bliz(:,:,1,idx-1),-1,2);
    bliz(:,:,2,idx) = circshift(bliz(:,:,2,idx-1),1,2);
    bliz(:,:,3,idx) = circshift(bliz(:,:,3,idx-1),-1);
    bliz(:,:,4,idx) = circshift(bliz(:,:,4,idx-1),1);
end

startingCol = find(data(1,:) == '.') -1;
endingCol = find(data(end,:) == '.') -1;

day24puzzle1result = tranverseMe(bliz, startingCol, endingCol) %#ok<NOPTS> 

function [time, finalBliz] = tranverseMe(bliz, startingCol, endingCol)
sizeOfMap = size(bliz(:,:,1,1));
finder = reshape([0 0; -1 0; 0 1; 0 -1; 1 0]',1,2,[]);
elves = false(sizeOfMap);
elves(1,startingCol) = 1;
idx = 2;
while 1
    blizIdx = mod(idx+1,size(bliz,4));
    blizIdx(blizIdx == 0) = size(bliz,4);
    blizNextSec = sum(bliz(:,:,:,blizIdx),3) ~= 0;
    [r,c] = ind2sub(sizeOfMap,find(elves)); % find elves
    options = reshape(pagetranspose([r c] + finder),2,[])'; % nghbrs and w8
    options = [options; 1 startingCol];
    options = options(~any(options < 1,2),:); % remove off U & L;
    options = options(options(:,1) <= sizeOfMap(1),:); % remove off D;
    options = options(options(:,2) <= sizeOfMap(2),:); % remove off R;
    options = options(~blizNextSec(sub2ind(sizeOfMap, ...
        options(:,1),options(:,2))),:);
    elves = false(sizeOfMap);
    elves(sub2ind(sizeOfMap,options(:,1),options(:,2))) = true;

    if elves(end,endingCol)
        break
    end
    idx = idx + 1;
end
time = idx + 1;
blizIdx = mod(idx+2,size(bliz,4));
blizIdx(blizIdx == 0) = size(bliz,4);
finalBliz = cat(4,bliz(:,:,:,blizIdx:end), bliz(:,:,:,1:blizIdx-1));
end
