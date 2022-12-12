%% day12puzzle1 - Daniel Breslan - Advent Of Code 2022
clear
clc
data = char(readlines("inputDemo.txt"));
data(1,1) = 'a';

[r,c] = find(data == 'E');
locs = [r,c];
data(data == 'E') = 'z';
data = double(data) - double('a') + 1;
day12puzzle1result = 0;

moveMe(data, locs)

function completePaths = moveMe(data, locs)
for idx = 1:500
    currentLocation = locs(end,:);
    if all(currentLocation == [1 1])
        warning("SUCESS!")
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
    if size(moveTo,1) ~= 1
        warning("too many, move to is:")
        disp(moveTo)
    elseif size(moveTo,1) == 0
        error("dead end")
    end
    locs = [locs; moveTo];
end
end


