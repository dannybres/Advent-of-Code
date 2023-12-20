%% day17puzzle2 - Daniel Breslan - Advent Of Code 2023
tic
map = readlines("input.txt").split("").double;
map = map(:,2:end-1);
maxN = 10;
seen = false(size(map,1),size(map,2),3,3,maxN);
q = PQ2(12e3);
q.push([0 1 1 0 0 0],0);
% next = 2;
while true
    o = q.pop;
    if rand() < 0.005
        o(1)
    end

    hl = o(1); r = o(2); c = o(3); dr = o(4); dc = o(5); n = o(6);
    if r == size(map,1) && c == size(map,2) && n >= 4 % found end
        break
    end
    if n ~= 0
        if seen(r,c,dr+2,dr+2,n) % seen before (from that direction)
            continue
        end
        seen(r,c,dr+2,dr+2,n) = true;
    end
    if n < maxN && n ~= 0 % go straight if < maxN
        nr = r + dr;
        nc = c + dc;
        if nr <= size(map,1) && nr > 0 && nc <= size(map,2) && nc > 0
            nhl = hl+map(nr,nc);
            q.push([nhl nr nc dr dc n+1],nhl);
        end
    end
    if n >= 4 || n == 0
        for idx = [0 1 0 -1;-1 0 1 0] % turn if moved forward enough
            if any(idx' ~= [dr dc]) && any(idx' ~= [-dr -dc])
                nr = r + idx(1);
                nc = c + idx(2);
                if nr <= size(map,1) && nr > 0 && nc <= size(map,2) && nc > 0
                    nhl = hl+map(nr,nc);
                    q.push([nhl nr nc idx(1) idx(2) 1],nhl);
                end
            end
        end
    end
end
day17puzzle2result = hl %#ok<NOPTS>







