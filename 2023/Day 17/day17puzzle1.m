%% day17puzzle1 - Daniel Breslan - Advent Of Code 2023
tic
profile on
map = readlines("input.txt").split("").double;
map = map(:,2:end-1);
maxN = 3;
seen = false(size(map,1),size(map,2),3,3,maxN);
q = nan(1e6,6);
q(1,:) = [0 1 1 0 0 0];
next = 2;
while true
    o = q(1,:);
    q(1) = Inf;
    hl = o(1); r = o(2); c = o(3); dr = o(4); dc = o(5); n = o(6);
    if r == size(map,1) && c == size(map,2) % found end
        break
    end
    if n
        if seen(r,c,dr+2,dr+2,n) % seen before (from that direction)
            q(1:next-1,:) = sortrows(q(1:next-1,:),1);
            continue
        end
        seen(r,c,dr+2,dr+2,n) = true;
    end
    if n < maxN && n % go straight if < 3
        nr = r + dr;
        nc = c + dc;
        if nr <= size(map,1) && nr > 0 && nc <= size(map,2) && nc > 0
            q(next,:) = [hl+map(nr,nc) nr nc dr dc n+1];
            next = next + 1;
        end
    end
 
    for idx = [0 1 0 -1;-1 0 1 0] % turn
        if any(idx' ~= [dr dc]) && any(idx' ~= [-dr -dc])
            nr = r + idx(1);
            nc = c + idx(2);
            if nr <= size(map,1) && nr > 0 && nc <= size(map,2) && nc > 0
                q(next,:) = [hl+map(nr,nc) nr nc idx(1) idx(2) 1];
                next = next + 1;
            end
        end
    end
    q(1:next-1,:) = sortrows(q(1:next-1,:),1);
end
toc
profile viewer
day17puzzle1result = hl