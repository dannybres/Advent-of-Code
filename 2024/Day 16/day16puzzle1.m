%% day16puzzle1 - Daniel Breslan - Advent Of Code 2024
m = char(readlines("input.txt"));
rd = [0 1];
[cr,cc] = find(m == 'S');
[tr,tc] = find(m == 'E');
n = 10e3;
q = nan(n,6);
q(1,:) = [0 cr cc rd nan];
qidx = 1;
reachTarget = false;
while true
    toProcessIdx = find(q(1:qidx,1) == min(q(1:qidx,1)));
    for idx = 1:height(toProcessIdx)
        item = q(toProcessIdx(idx),:);
        ccost = item(1);
        cr = item(2);
        cc = item(3);
        cdir = item(4:5);
        for d = [-1 0;1 0;0 -1;0 1]'
            nr = cr + d(1);
            nc = cc + d(2);
            if m(nr,nc) == '#', continue, end
            if all(cdir == -d'), continue, end
            if all([nr nc] == [tr tc])
                reachTarget = true;
                day16puzzle1result = ccost + 1;
                break
            end
            if any(all([nr,nc,d']==q(1:qidx-1,2:5),2)),break,end
            qidx = qidx + 1;
            if all(d' == cdir)
                q(qidx,:) = [ccost+1,nr,nc,d',toProcessIdx(idx)];
            else

                q(qidx,:) = [ccost+1001,nr,nc,d',toProcessIdx(idx)];
            end
        end
    end
    if reachTarget, break, end
    q(toProcessIdx,1) = inf;
end

day16puzzle1result