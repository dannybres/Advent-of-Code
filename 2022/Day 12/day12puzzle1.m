%% day12puzzle1 - Daniel Breslan - Advent Of Code 2022
clear
clc
data = char(readlines("input.txt"));
data(1,1) = 'a';

[r,c] = find(data == 'E');
locs = [r,c];
data(data == 'E') = 'z';
data = double(data) - double('a') + 1;
day12puzzle1result = 0;
completedPaths = cell(0);
deadPlaces = ones(0,2);
[completedPaths, deadPlaces] = moveMe(data, locs, completedPaths, deadPlaces);
min(cellfun(@numel, completedPaths)/2)-1

function [completedPaths, deadPlaces] = moveMe(data, locs, completedPaths, deadPlaces)
ogLocs = locs;
for i = 1:5000
    currentLocation = locs(end,:);
    if all(currentLocation == [1 1])
        completedPaths = [completedPaths {locs}];
        return
    end
    mover = [0 1; 1 0; 0 -1; -1 0];
    options = currentLocation + mover;
    options = options(~any(options < 1,2),:);
    options = options(~(options(:,2) > size(data,2)),:);
    options = options(~(options(:,1) > size(data,1)),:);
    moveTo = options(data(sub2ind(size(data),options(:,1),options(:,2))) >=...
        data(currentLocation(1),currentLocation(2)) - 1,:);
    moveTo = moveTo(~ismember(moveTo,locs,'rows'),:);
%     moveTo = moveTo(~ismember(moveTo,deadPlaces,'rows'),:);
    if size(moveTo,1) > 1
        for idx = 1:size(moveTo,1)
	        [completedPaths, deadPlaces] = moveMe(data, [locs; moveTo(idx,:)], completedPaths, deadPlaces);
            deadPlaces = [deadPlaces;moveTo(idx,:)];
        end
    elseif size(moveTo,1) == 0
        deadPlaces = [deadPlaces; locs(~ismember(locs,ogLocs,'rows'),:)];
        return
    end
    locs = [locs; moveTo]; %#ok<*AGROW> 
end
end


