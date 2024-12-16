%% day16puzzle2 - Daniel Breslan - Advent Of Code 2024
m = char(readlines("input.txt"));
rd = [0 1];
[sr,sc] = find(m == 'S');
[tr,tc] = find(m == 'E');
n = 2e6;
q = nan(n,6);
q(1,:) = [0 sr sc rd false];
qidx = 1;
reachTarget = false;
while true
    minValInQ = min(q(~q(1:qidx,end),1));
    toProcessIdx = find(q(1:qidx,1) == minValInQ);
    for idx = 1:height(toProcessIdx)
        item = q(toProcessIdx(idx),:);
        ccost = item(1);
        cr = item(2);
        cc = item(3);
        cdir = item(4:5);
        for d = [-1 0;1 0;0 -1;0 1]'
            dir = d';
            nr = cr + d(1);
            nc = cc + d(2);
            if m(nr,nc) == '#', continue, end
            if all(cdir == -dir), continue, end
            if all([nr nc] == [tr tc])
                reachTarget = true;
                score = ccost + 1;
                break
            end
            if any(all([nr,nc,d']==q(1:qidx-1,2:5),2)),break,end
            qidx = qidx + 1;
            if all(dir == cdir)
                q(qidx,:) = [ccost+1,nr,nc,dir,false];
            else
                q(qidx,:) = [ccost+1001,nr,nc,dir,false];
            end
        end
    end
    if reachTarget, break, end
    q(toProcessIdx,end) = true;
end

fq = [tr tc -1 0 score]; % always finished from below - both examples and my input
visited = [];
while height(fq)
    item = fq(1,:);
    fq(1,:) = [];
    cl = item(1:2);
    cd = item(3:4);
    cs = item(5);
    visited = [visited;cl]; %#ok<*AGROW>
    for d = [-1 0;1 0;0 -1;0 1]'
        dir = d';
        nl = cl + dir;
        if m(nl(1),nl(2)) == '#',continue,end
        if any(all(nl == visited,2)),continue,end
        possiblePaths = q(all(q(1:qidx,2:3) == nl,2),:);
        for pp = 1:height(possiblePaths)
            possiblePath = possiblePaths(pp,:);
            if all(cd == possiblePath(4:5))
                ns = cs - 1;
            else
                ns = cs - 1001;
            end
            if possiblePath(1) == ns
                fq = [fq; nl, possiblePath(4:5), possiblePath(1)]; 
            end
        end
    end
end
day16puzzle1result = height(unique(visited,'rows'))