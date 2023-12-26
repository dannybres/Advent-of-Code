%% day23puzzle2 - Daniel Breslan - Advent Of Code 2023
map = char(readlines("input.txt"));
map(map == '<' | map == '>' | map == 'v' | map == '^') = '.';
startPt = [1 find(map(1,:) == '.')];
seen = false(size(map));
seen(map == '#') = true;
day23puzzle2result = step(map,startPt(1),startPt(2),seen) ...
    - sum(map == '#','all')

function out = step(map,x,y,seen)
out = 0;
endPt = [size(map,1),find(map(end,:) == '.')];
o = bwconncomp(~seen);
if numel(o.PixelIdxList) > 1
    for idx = 1:numel(o.PixelIdxList)
        if ~ all(all(any(o.PixelIdxList{idx} == ...
                [size(map,1) * (size(map,2)-1), ...
                sub2ind(size(map),x,y)])))
            return
        end
    end
end
if x == endPt(1) && y == endPt(2)
    out = sum(seen,'all');
    if rand() < 0.05
        disp(compose("[%i,%i] with %i steps",x,y,sum(seen,'all')))
    end
    return
end
seen(x,y) = true;
dir = [0 1; 0 -1;1 0;-1 0]; % R L D U
if map(x,y) ~= '.'
    switch map(x,y)
        case '<'
            dir = [0 -1];
        case '>'
            dir = [0 1];
        case 'v'
            dir = [1 0];
        case '^'
            dir = [-1 0];
    end
end
for idx = 1:size(dir,1)
    xx = x + dir(idx,1); yy = y + dir(idx,2);
    if xx > 0 && yy > 0 && xx <= size(map,1) && yy <= size(map,1)
        if map(xx,yy) ~='#' && ~seen(xx,yy)
            if map(xx,yy) ~= '.'
                switch map(xx,yy)
                    case '<'
                        if dir(idx,2) ~= -1
                            continue
                        end
                    case '>'
                        if dir(idx,2) ~= 1
                            continue
                        end
                    case 'v'
                        if dir(idx,1) ~= 1
                            continue
                        end
                    case '^'
                        if dir(idx,1) ~= -1
                            continue
                        end
                end
            end
            out = max(out,step(map,xx,yy,seen));
        end
    end
end
end