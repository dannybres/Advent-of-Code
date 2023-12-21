%% day17puzzle2 - Daniel Breslan - Advent Of Code 2023
tic
profile on
map = readlines("input.txt").split("").double;
map = map(:,2:end-1);
maxN = 10;
seen = false(size(map,1),size(map,2),3,3,maxN);
q = java.util.PriorityQueue;
qe = nan(3e6,6);
next = 1;
qe(next,:) = [0 1 1 0 0 0];
q.add(encode(0,next));
next = next + 1;
target = size(map);
% target = [40 40];
while true
    idx = decode(q.remove());
    o = qe(idx,:);
    hl = o(1); r = o(2); c = o(3); dr = o(4); dc = o(5); n = o(6);
    if r == target(1) && c == target(2) && n >= 4 % found end
        break
    end
    if n ~= 0
        sPerN = seen(r,c,dr+2,dr+2,:);
        if sPerN(n)  % seen before (from that direction)
            continue
        end
        if n > 3 && any(sPerN(4:end))
            if n > find(sPerN(4:end),1) + 3
                continue
            end
        end
        seen(r,c,dr+2,dr+2,n) = true;
    end
    if n < maxN && n ~= 0 % go straight if < maxN
        nr = r + dr;
        nc = c + dc;
        if nr <= size(map,1) && nr > 0 && nc <= size(map,2) && nc > 0
            nhl = hl+map(nr,nc);
            qe(next,:) = [nhl nr nc dr dc n+1];
            q.add(encode(nhl,next));
            next = next + 1;
        end
    end
    if n >= 4 || n == 0
        for idx = [0 1 0 -1;-1 0 1 0] % turn if moved forward enough
            if any(idx' ~= [dr dc]) && any(idx' ~= [-dr -dc])
                nr = r + idx(1);
                nc = c + idx(2);
                if nr <= size(map,1) && nr > 0 && nc <= size(map,2) && nc > 0
                    nhl = hl+map(nr,nc);
                    qe(next,:) = [nhl nr nc idx(1) idx(2) 1];
                    q.add(encode(nhl,next));
                    next = next + 1;
                end
            end
        end
    end
end
day17puzzle2result = hl %#ok<NOPTS>
toc
profile viewer
function u = encode(value,index)
% value should be non-negative
% index should be an integer
u = sprintf('%010d,%d',uint64(java.lang.Float.floatToIntBits(value)),index);
end
function [index,value] = decode(u)
value_index = sscanf(u,'%d,%d',2);
value = java.lang.Float.intBitsToFloat(value_index(1));
index = value_index(2);
end
