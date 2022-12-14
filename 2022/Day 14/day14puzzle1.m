%% day14puzzle1 - Daniel Breslan - Advent Of Code 2022
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

bottomOfCave = size(cave,1);

% Falling Sand
unit = 0;
while 1
    fallingSand = [0 501];
    while 1
        clear newSpace
        if fallingSand(end,1) == bottomOfCave
            break
        end
        if double(cave(fallingSand(end,1)+1,fallingSand(end,2))) == 0
            % empty below
            newSpace = fallingSand(end,:) + [1 0];
        elseif double(cave(fallingSand(end,1)+1,fallingSand(end,2)-1)) == 0
            % empty left below
            newSpace = fallingSand(end,:) + [1 -1];
        elseif double(cave(fallingSand(end,1)+1,fallingSand(end,2)+1)) == 0
            % empty right below
            newSpace = fallingSand(end,:) + [1 1];
        end
        if exist('newSpace','var')
            % add next falling space
            fallingSand = [fallingSand; newSpace];
        else
            % no more space to move
            break
        end
    end

    if fallingSand(end,2)+1 == size(cave,2) % make cave bigger
        cave = [cave repmat(char(0),size(cave,1),1)];
    end
    if fallingSand(end,1) == bottomOfCave % into the void
        cave(sub2ind(size(cave),fallingSand(2:end,1),...
            fallingSand(2:end,2))) = "~"; % mark last path
        break
    else
        cave(fallingSand(end,1),fallingSand(end,2)) = '+'; % mark sand
    end
    unit = unit + 1; % increment unit count
end
day14puzzle1result = unit %#ok<NOPTS>

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
title(day14puzzle1result + " units of sand come to rest")
saveas(f,'Puzzle1.png')