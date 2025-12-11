data = readlines("input.txt").split(",").double;
clc

x = data(:,1); % get co-ords
y = data(:,2);

x = [x; x(1)]; % add first to end to make a loop
y = [y; y(1)];

xs = unique(x); % get uniques to enable compression
ys = unique(y);

xl = dictionary((1:numel(xs))',xs); % look up from compressed idx to x
yl = dictionary((1:numel(ys))',ys);

xll = dictionary(xl.values,xl.keys); % reverse lu - x to compressed idx
yll = dictionary(yl.values,yl.keys);

cx = xll(x); cy = yll(y); % make compressed indexes

edgeMap = false(max(cx)+2,max(cy)+2); % make a map of edges (true = edge)
for idx = 1:numel(cx) - 1
    xf = cx(idx):cx(idx+1);
    if isempty(xf)
        xf = cx(idx+1):cx(idx);
    end
    yf = cy(idx):cy(idx+1);
    if isempty(yf)
        yf = cy(idx+1):cy(idx);
    end
    edgeMap(xf+1,yf+1) = true;
end

outsideMap = false(max(cx)+2,max(cy)+2); % flood fill outside (1 = outside)
outsideMap(1,1) = true;
queue = [1,1];
while queue
    % queue
    qy = queue(1,1); qx = queue(1,2);
    queue(1,:) = [];

    for dir = [-1 0;1 0;0 -1;0 1]'
        nx = qx + dir(1);
        ny = qy + dir(2);
        if nx < 1 || ny < 1 || ...
                ny > height(outsideMap) || nx > width(outsideMap)
            continue
        end
        if outsideMap(ny,nx) || edgeMap(ny,nx)
            continue
        end
        outsideMap(ny,nx) = true;
        queue = [queue;ny nx];
    end
end

redGreen = ~outsideMap; % map of red green (true = red green)
psaRG =  cumsum(cumsum(redGreen),2); % Prefix sum array

% a prefix sum array sums all the values left and above whatever is it s
% psa of. so if you have a large logical matrix and want to know the number
% of 1s in a region this can be done by taking the bottom right value and
% then subtract the left region, top region and adding back in the top left
% region as we have deleted it twice.
% https://www.youtube.com/watch?v=toDrFDh7VNs&t=1271s


function valid = validatePrefixSumArray(psa, y1, x1, y2, x2)
    % checks if the region bound by coords is all 1s using PSA
    x1 = x1 + 1; x2 = x2 + 1; y1 = y1 + 1; y2 = y2 + 1; % to compressed 
    % coords which has a border of 0s that is 1 deep
    leftRegion = psa(y2,x1-1);
    topRegion = psa(y1-1,x2);
    topleftRegion = psa(y1-1,x1-1);
    count = psa(y2,x2) - leftRegion - topRegion + topleftRegion;
    valid = count == (x2 - x1 + 1) * (y2 - y1 + 1);
end

day9puzzle2result = 0;
% solutions = [nan nan];
for p1Idx = 1:height(x)
    for p2Idx = 1:height(x)
        if p1Idx >= p2Idx
            continue
        end
        cornerX = sort(cx([p1Idx,p2Idx]));
        cornerY = sort(cy([p1Idx,p2Idx]));
        if validatePrefixSumArray(psaRG,...
                cornerX(1),cornerY(1),cornerX(2),cornerY(2))
            % I swap coords somewhere, idk how!
            prior = day9puzzle2result;
            day9puzzle2result = max([day9puzzle2result ...
             (abs(diff(xl(cornerX))) + 1) * (abs(diff(yl(cornerY))) + 1)]);
            if prior ~= day9puzzle2result
                % solutions = [p1Idx p2Idx];
            end
        end
    end
end
day9puzzle2result

% close all
% figure
% tiledlayout('flow')
% nexttile
% imshow(edgeMap)
% nexttile
% imshow(outsideMap)
% 
% patch([cy(solutions([1 1 2 2]))]+1,[cx(solutions([1 2 2 1]))]+1,'b')