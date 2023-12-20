%% day16puzzle2 - Daniel Breslan - Advent Of Code 2023
tic
m = double(char(readlines("input.txt")));
n = length(m);
dir = [-1 0;0 1;1 0;0 -1];

sl = [[(1:n)' repmat([1 2],n,1)];...
    [ones(n,1) (1:n)' repmat(3,n,1)];...
    [repmat(n,n,1) (1:n)' ones(n,1)];...
    [(1:n)' repmat([n 4],n,1)]...
    ];
r = nan(height(sl),1);
for idx = 1:height(sl)
    state = false([size(m),4]);
    loc = sl(idx,:);
    switch m(loc(1),loc(2))
        case '/'
            dirCh = 1;
            if loc(3) == 4 || loc(3) == 2 % turn left
                dirCh = -1;
            end
            loc(3) = loc(3)+dirCh;
        case '\'
            dirCh = 1;
            if loc(3) == 1 || loc(3) == 3 % turn left
                dirCh = -1;
            end
            loc(3) = loc(3)+dirCh;
    end
    if loc(1,3) == 0
        loc(1,3) = 4;
    end
    if loc(1,3) == 5
        loc(1,3) = 1;
    end
    while height(loc)
        l = loc(1,:);
        if state(l(1),l(2),l(3))
            loc(1,:) = [];
            continue
        end
        state(l(1),l(2),l(3)) = true;
        newLoc = l(1:2) + dir(l(3),:);
        % check if dead
        if any(newLoc < 1) || ...
                newLoc(1) > size(m,1) || ...
                newLoc(2) > size(m,2)
            loc(1,:) = [];
            continue
        end

        moveTo = m(newLoc(1),newLoc(2));
        switch  moveTo
            case '.'
                loc(1,1:2) = newLoc;
            case '|'
                if l(3) == 2 || l(3) == 4
                    loc(1,:) = [newLoc 1];
                    loc = [loc; [newLoc 3]]; %#ok<*AGROW>
                else
                    loc(1,1:2) = newLoc;
                end
            case '-'
                if l(3) == 1 || l(3) == 3
                    loc(1,:) = [newLoc 2];
                    loc = [loc; [newLoc 4]];
                else
                    loc(1,1:2) = newLoc;
                end
            case '/'
                dirCh = 1;
                if l(3) == 4 || l(3) == 2 % turn left
                    dirCh = -1;
                end
                loc(1,:) = [newLoc l(3)+dirCh];
            case '\'
                dirCh = 1;
                if l(3) == 1 || l(3) == 3 % turn left
                    dirCh = -1;
                end
                loc(1,:) = [newLoc l(3)+dirCh];
        end
        if loc(1,3) == 0
            loc(1,3) = 4;
        end
        if loc(1,3) == 5
            loc(1,3) = 1;
        end
    end
    state = sum(state,3);
    r(idx) = nnz(state);
end

day16puzzle2result = max(r) %#ok<NOPTS>
toc