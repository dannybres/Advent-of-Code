%% day23puzzle1 - Daniel Breslan - Advent Of Code 2023
data = char(readlines("input.txt"));

startPt = [1 find(data(1,:) == '.')];
step(data,startPt(1),startPt(2),false(size(data)))

day23puzzle1result = 0;

function out = step(map,x,y,seen)
out = 0;
endPt = [size(map,1),find(map(end,:) == '.')];
if x == endPt(1) && y == endPt(2)
    % disp(compose("[%i,%i] with %i steps",x,y,sum(seen,'all')))
    out = sum(seen,'all');
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





% endPt = [size(data,1),find(data(end,:) == '.')];