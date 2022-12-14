%% day14puzzle2 - Daniel Breslan - Advent Of Code 2022
tic
data = readlines("input.txt");
cave = char();

% Build Cave
for idx = 1:numel(data)
    paths = data(idx).split(" -> ").split(",").double()+1;
    for pidx = 1:size(paths,1)-1
        cave(min(paths(pidx,2),paths(pidx+1,2)):...
            max(paths(pidx,2),paths(pidx+1,2)),...
            min(paths(pidx,1),paths(pidx+1,1)):...
            max(paths(pidx,1),paths(pidx+1,1))) = '#';
    end
end
cave = [cave repmat(char(0),size(cave,1),size(cave,1))];
bottomOfCave = size(cave,1);
cave(bottomOfCave+2,:) = '#';


% Falling Sand
unit = 0;
while 1
    fallingSandD = nan(size(cave,1)+1,2);
    fallingSandD(1,:) = [0 501];
    fsidx = 1;
    while 1
        lastSand = fallingSandD(fsidx,:);
        fsidx = fsidx + 1;
        newSpace = nan(1,2);
        if double(cave(lastSand(1)+1,lastSand(2))) == 0
            % empty below
            newSpace = lastSand + [1 0];
        elseif double(cave(lastSand(1)+1,lastSand(2)-1)) == 0
            % empty left below
            newSpace = lastSand + [1 -1];
        elseif double(cave(lastSand(1)+1,lastSand(2)+1)) == 0
            % empty right below
            newSpace = lastSand + [1 1];
        end
        if ~all(isnan(newSpace))
            % add next falling space
            fallingSandD(fsidx,:) = newSpace;
        else
            % no more space to move
            break
        end
    end
    cave(lastSand(1),lastSand(2)) = '+'; % mark sand
    unit = unit + 1; % increment unit count
    if all(lastSand == [1 501])
        break
    end
end
cave(:,find(any(cave == '+'),1)-2:end)
day14puzzle2result = unit %#ok<NOPTS>
toc
%% visualise
f = figure();
cc = cave(:,find(any(cave == '+'),1)-2:end);
img = ones(size(cc,1),size(cc,2),3);
idxAll = false(size(cc));
idxWall = cc == '#';
idxSand = cc == '+';
idxLast = cc == '~';

img(:,:,1) = idxWall;
img(:,:,2) = idxSand;
img(:,:,3) = idxLast;

imshow(repelem(img,5,5))
title(day14puzzle2result + " units of sand come to rest")
saveas(f,'Puzzle2.png')