%% day16puzzle2 - Daniel Breslan - Advent Of Code 2024
m = char(readlines("input.txt"));
initialDirection = [0 1];
[cr,cc] = find(m == 'S');
[er,ec] = find(m == 'E');
n = 10e6;
q = nan(n,5);
q(1,:) = [0 cr cc initialDirection ];
qidx = 1;
bestScore = Inf;

endStates = [];

seen = false(size(m,1),size(m,2),4); % state whether proccessed (once it is
% processed, we know this is the shortest path to that square with that dir
% so no need to queue again as it can only be longer.
lowestCost = inf * ones(size(m,1),size(m,2),4);
backtrack = cell(size(m,1),size(m,2),4);
while true
    toProcessIdx = find(q(1:qidx,1) == min(q(1:qidx,1)));
    if q(toProcessIdx(1),1) > bestScore
        break
    end

    for idx = 1:height(toProcessIdx)
        item = q(toProcessIdx(idx),:);
        ccost = item(1);
        cr = item(2);
        cc = item(3);
        cdir = item(4:5);

        if all([cr cc] == [er ec]) % reached the end
            endStates = [endStates;cr,cc,cdir]; %#ok<*AGROW>
            bestScore = ccost;
            continue
        end

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
            nextCost = move(5);
            lowestToHere = lowestCost(nextRow,nextCol,...
                (sum(nextDir .* [3 1]) + 5) / 2);
            if nextCost > lowestToHere, continue, end
            if nextCost < lowestToHere
                backtrack{nextRow,nextCol,...
                    (sum(nextDir .* [3 1]) + 5) / 2} = [];
                lowestCost(nextRow,nextCol,...
                    (sum(nextDir .* [3 1]) + 5) / 2) = nextCost;
            end
            backtrack{nextRow,nextCol,(sum(nextDir .* [3 1]) + 5) / 2} =...
                [backtrack{nextRow,nextCol,...
                (sum(nextDir .* [3 1]) + 5) / 2};cr cc cdir];
            if m(nextRow,nextCol) == '#', continue, end % if wall skip
            if seen(nextRow,nextCol,(sum(nextDir .* [3 1]) + 5) / 2)
                continue
            end % processed already, do not queue again, can only be longer
            if any(all([nextCost,nextRow,nextCol,nextDir] == q(1:qidx,:),2))
                continue
            end % already queued that item exactly (cost,r,c,dir), skip
            qidx = qidx + 1;
            q(qidx,:) = [nextCost,nextRow,nextCol,nextDir]; % add to queue
        end
    end
    q(toProcessIdx,1) = inf;
end

visited = nan(1e3,4);
vidx = 1;
visited(vidx,:) = endStates;
cidx = 1;
while ~isnan(visited(cidx))
    from = backtrack{visited(cidx,1),visited(cidx,2),...
        (sum(visited(cidx,3:4) .* [3 1]) + 5) / 2};
    for fidx = 1:height(from)
        if any(all(from(fidx,:) == visited(1:vidx,:),2))
            continue
        end
        visited(vidx+1,:) = from(fidx,:);
        vidx = vidx + 1;
    end
    cidx = cidx + 1;
end
day16puzzle1result = height(unique(visited(1:vidx,1:2),"rows"))

% m(sub2ind(size(m),visited(1:vidx,1),visited(1:vidx,2))) = '@';
% m(m=='.') = ' ';
% m(m=='#') = '.';