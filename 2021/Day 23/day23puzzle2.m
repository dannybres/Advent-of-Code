clc
profile on
clear all

for name = ""%["Demo" ""]
    tic
    data = readlines("input" + name + ".txt");
    data(4:5) = data(4:5) + "  ";
    data = char(data);
    data = data(2:end-1, 2:end-1);
    new =      [' #D#C#B#A# '
        ' #D#B#A#C# '];
    data = [data(1:2,:); new;data(end,:)];
    map = [0 1 nan 2 nan 3 nan 4 nan 5 6
        nan nan 7 nan 11 nan 15 nan 19 nan nan
        nan nan 8 nan 12 nan 16 nan 20 nan nan
        nan nan 9 nan 13 nan 17 nan 21 nan nan
        nan nan 10 nan 14 nan 18 nan 22 nan nan];

    types = 'ABCD';
    state = nan(1,4*4);
    for idx = 1:numel(types)
        [r,c] = find(data == types(idx));
        for ci = 1:4
            state((idx - 1) * 4 + ci) = map(r(ci),c(ci));
        end
    end

    cost = heuristic(state);
    q = cell(1,20e6);

    visited = containers.Map('KeyType','uint64','ValueType','logical');

    idx = 0;
    done = false;

    for qjosjod = 1:20e9
        if idx == 0
            queueCost = cost;
            allApods = state;
            idx = idx + 1;
        else
            if isempty(q{idx})
                idx = idx + 1;
                continue
            else
                queueCost = idx;
                allApods = q{idx};
                q{idx} = [];
            end
        end
        for next = 1:height(allApods)
            apods = allApods(next,:);

            if rand() < 0.0001 % logging
                disp(compose("Item %i for cost %i",idx,queueCost))
                % if rand() < 0.5
                %     visualiseApods(apods)
                % end
            end

            if all([sort(apods(1:4)), sort(apods(5:8)), ...
                    sort(apods(9:12)), sort(apods(13:16))] == 7:22) % finished
                done = true;
                break
            end

            h = stateHash(apods);
            if isKey(visited, h)
                continue
            end
            visited(h) = true;

            [newCosts,neighbours] = findNeighbours(apods); % options
            currentCost = queueCost - heuristic(apods);

            for nIdx = 1:height(neighbours)
                newQueuePosition = newCosts(nIdx) + currentCost + heuristic(neighbours(nIdx,:));
                q{newQueuePosition} = [q{newQueuePosition};neighbours(nIdx,:)];


            end

        end
        if done
            break
        end
    end
    if queueCost == 12521 || queueCost == 14467 || queueCost == 44169 || queueCost == 48759
        disp(compose("Puzzle Solved - cost %i",queueCost))
    end


    toc
end

profile viewer

function value  = heuristic(apods)
value = 0;
for idx = 1:numel(apods)
    [~, ~, destinationRoom, ~,cost] = getInfo(idx);
    value = value + min([numberOfSteps(apods(idx),destinationRoom + 1), numberOfSteps(apods(idx),destinationRoom)]) * cost;
end
end

function [costs,neighbours] = findNeighbours(apods)
costs = [];
neighbours = [];
for aIdx = 1:numel(apods)

    apod = apods(aIdx);
    [~, ~, destinationRoom,partners,cost] = getInfo(aIdx);
    % is it satisfied?
    if apod == destinationRoom + 3 ||...
            (apod == destinationRoom + 2 && any(apods(partners) == destinationRoom + 3)) || ...
            (apod == destinationRoom + 1 && all(any(apods(partners)' == destinationRoom + (2:3)))) || ...
            (apod == destinationRoom && all(any(apods(partners)' == destinationRoom + (1:3))))
        %disp(compose("%i (%c - %i) is satified",apod,type,aIdx))
        continue
    end
    % into destination from hall
    if apod < 7
        if (~any(apods==destinationRoom) && all(any(apods(partners)' == destinationRoom + (1:3)))) || ...% entrance to room is clear and deeper in room is partners
                (~any(apods==destinationRoom + 1) && all(any(apods(partners)' == destinationRoom + (2:3)))) || ...
                (~any(apods==destinationRoom + 2) && any(apods(partners) == destinationRoom + 3)) || ...
                ~any(apods==destinationRoom +3)
            if ~cannotGet(apods,apod,destinationRoom)
                for depth = 3:-1:0
                    if ~any(apods==destinationRoom + depth)
                        break
                    end
                end
                %disp(compose("%i (%c - %i) Move to destination %i",apod,type,aIdx,destinationRoom + depth))
                newState = apods;
                newState(aIdx) = destinationRoom + depth;
                newCost = numberOfSteps(apod,destinationRoom + depth) * cost;
                costs = [costs;
                    newCost];
                neighbours = [neighbours;
                    newState];            else
                %disp(compose("%i (%c - %i) Blocked, cannot move to destination %i",apod,type,aIdx,destinationRoom))
            end

        else
            %disp(compose("%i (%c - %i) No destination available: %i",apod,type,aIdx,destinationRoom))
        end
        if height(neighbours)
            continue
        end
    else
        % from room into hall
        if isBlockedInRoom(apods,aIdx)
            %disp(compose("%i (%c - %i) is blocked",apod,type,aIdx))
            continue
        end
        for hIdx = 0:6
            if cannotGet(apods,apod,hIdx)
                continue
            end
            %disp(compose("%i (%c - %i) Move to hall %i",apod,type,aIdx,hIdx))
            newState = apods;
            newState(aIdx) = hIdx;
            newCost = numberOfSteps(apod,hIdx) * cost;

            costs = [costs;
                newCost];
            neighbours = [neighbours;
                newState];
        end
    end
end
end

function map = visualiseApods(apods)
map = (['...........'
    '##.#.#.#.##'
    ' #.#.#.#.# '
    ' #.#.#.#.# '
    ' #.#.#.#.# ']);
numMap = [0 1 nan 2 nan 3 nan 4 nan 5 6
    nan nan 7 nan 11 nan 15 nan 19 nan nan
    nan nan 8 nan 12 nan 16 nan 20 nan nan
    nan nan 9 nan 13 nan 17 nan 21 nan nan
    nan nan 10 nan 14 nan 18 nan 22 nan nan];
for idx = 1:numel(apods)
    map(apods(idx) == numMap) = getInfo(idx);
end
end

function bool = isBlockedInRoom(apods,idx)
tops = 7:4:19;
topOfIt = tops(find(tops<=apods(idx),1,"last"));
needToBeFree = topOfIt:apods(idx)-1;

bool = ~all(apods' ~= needToBeFree,"all");

end

function [type, idx, destinationRoom, partners,cost] = getInfo(number)
idx = ceil(number/4);
type = 'A' + idx - 1;
destinationRoom = 3 + idx * 4;
allApods = reshape(1:16,4,4);
allApods = allApods(:,any(allApods == number));
partners = allApods(allApods ~= number);
cost = 10^(idx-1);
end

function steps = numberOfSteps(from,to)
colMap = [0 1 3 5 7 9 10 2 2 2 2 4 4 4 4 6 6 6 6 8 8 8 8];
depMap = [0 0 0 0 0 0  0 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4];
fc = colMap(from + 1); tc = colMap(to + 1);
fd = depMap(from + 1); td = depMap(to + 1);
depth = (fd + td) .* double(fc ~= tc);
steps = depth + abs(fc - tc);
end

function bool = cannotGet(apods,from,to)

colMap = [0 1 3 5 7 9 10 2 2 2 2 4 4 4 4 6 6 6 6 8 8 8 8];
fc = colMap(from + 1); tc = colMap(to + 1);
podsInHall = colMap(apods(apods < 7) + 1);
podsInHall(podsInHall == fc) = [];

bool = any(podsInHall >= min([fc tc]) & podsInHall <= max([fc tc]));
end


function h = stateHash(s)
% s : 1x16 values in 0..22

s = uint64(s);
h = uint64(0);

for i = 1:16
    h = bitxor(h, rotl(h, 5));
    h = bitxor(h, s(i));
end
end

function y = rotl(x,n)
y = bitor(bitshift(x,n), bitshift(x, n-64));
end
