%% day16puzzle1 - Daniel Breslan - Advent Of Code 2024
m = char(readlines("input.txt"));
rd = [0 1];
[cr,cc] = find(m == 'S');
[tr,tc] = find(m == 'E');
n = 10e6;
q = nan(n,5);
q(1,:) = [0 cr cc rd ];
qidx = 1;
reachTarget = false;

seen = false(size(m,1),size(m,2),4); % state whether proccessed (once it is
% processed, we know this is the shortest path to that square with that dir
% so no need to queue again as it can only be longer.
while true
    toProcessIdx = find(q(1:qidx,1) == min(q(1:qidx,1)));
    for idx = 1:height(toProcessIdx)
        item = q(toProcessIdx(idx),:);
        ccost = item(1);
        cr = item(2);
        cc = item(3);
        cdir = item(4:5);
        seen(cr,cc,(sum(cdir .* [3 1]) + 5) / 2) = true; % this maths maps
        % (-1 0), (0 -1), (0 1), (1 0) to 1 to 4, to save a lookup, used
        % later to when checking if seen
        for move = [cr cc -cdir(2) cdir(1) ccost + 1000;...
                cr cc cdir(2) -cdir(1) ccost + 1000;...
                [cr cc] + cdir, cdir, ccost + 1]'% dont move and turn, 
            % dont move and turn, move forwards
            % (c -r) is a clockwise turn and (-c r) is a c.clockwise one
            nextRow = move(1);
            nextCol = move(2);
            nextDir = move(3:4)';
            ncost = move(5);
            if m(nextRow,nextCol) == '#', continue, end % if wall skip
            if all([nextRow nextCol] == [tr tc]) % reached the end
                reachTarget = true;
                day16puzzle1result = ccost + 1;
                break
            end
            if seen(nextRow,nextCol,(sum(nextDir .* [3 1]) + 5) / 2)
                continue
            end % processed already, do not queue again, can only be longer
            qidx = qidx + 1;
            q(qidx,:) = [ncost,nextRow,nextCol,nextDir]; % add to queue
        end
    end
    if reachTarget, break, end
    q(toProcessIdx,1) = inf;
end

day16puzzle1result

% mm = ones(size(m));
% mm(sub2ind(size(mm),q(1:qidx,2),q(1:qidx,3))) = 0;
% mm(m=='#') = 0.5;
% imagesc(mm)
% drawnow
% shg