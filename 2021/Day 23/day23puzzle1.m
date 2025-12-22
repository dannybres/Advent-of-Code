clc
% profile on
clear all
for name = ["Demo" ""]
    tic

    data = readlines("input" + name + ".txt");
    data(4:5) = data(4:5) + "  ";
    data = char(data);
    data = data(2:end-1, 2:end-1);

    map = [0 1 nan 2 nan 3 nan 4 nan 5 6
        nan nan 7 nan 9 nan 11 nan 13 nan nan
        nan nan 8 nan 10 nan 12 nan 14 nan nan];

    types = 'ABCD';
    state = nan(1,8);
    for idx = 1:numel(types)
        [r,c] = find(data == types(idx));
        for ci = 1:2
            state((idx - 1) * 2 + ci) = map(r(ci),c(ci));
        end
    end
    % cost = heuristic(state);
    cost = 0;

    q = cell(1,20e5);

    si = repmat({15},1,8);
    visited = false(si{:});
    idx = 0;
    done = false;
    for qjosjod = 1:2e4
        if idx == 0
            queueCost = cost;
            allApods = state;
        else
            if isempty(q{idx})
                idx = idx + 1;
                continue
            else
                queueCost = idx;
                allApods = q{idx};
            end
        end
        idx = idx + 1;
        for next = 1:height(allApods)
            apods = allApods(next,:);
            if rand() < 0.00002
                disp(compose("Item %i for cost %i",idx,queueCost))
            end

            if all([sort(apods(1:2)), sort(apods(3:4)), sort(apods(5:6)), sort(apods(7:8))] == 7:14)
                done = true;
                break
            end
            vi = num2cell(apods+1);
            if visited(vi{:})
                continue
            end
            visited(vi{:}) = true;
            [newCosts,neighbours] = findNeighbours(apods);
            % ch = heuristic(apods);
            currentCost = queueCost;
            for nIdx = 1:height(neighbours)
                nh = 0;%heuristic(neighbours(nIdx,:));
                q{newCosts(nIdx) + currentCost + nh} = [q{newCosts(nIdx) + currentCost + nh};neighbours(nIdx,:)];
            end
        end
        if done
            break
        end
    end
    disp(compose("Puzzle Solved - Item %i for cost %i",idx,queueCost))
    disp("")
    toc
end

% profile viewer

% function value  = heuristic(apods)
% persistent cache
% if isempty(cache)
%     cache = nan(1,15^8);
%     disp(compose("cache built - %i items",numel(cache)))
% end
% key = encode8x15_fast(apods);
% value = cache(key);
% if isnan(value)
%     value = 0;
%     for idx = 1:numel(apods)
%         [~, ~, destinationRoom, ~,cost] = getInfo(idx);
%         value = value + min([numberOfSteps(apods(idx),destinationRoom + 1), numberOfSteps(apods(idx),destinationRoom)]) * cost;
%     end
%     cache(key) = value;
% end
% 
% end

function [costs,neighbours] = findNeighbours(apods)
% clc
costs = [];
neighbours = [];
% ch = heuristic(apods);
for aIdx = 1:numel(apods)

    apod = apods(aIdx);
    [type, idx, destinationRoom,partner,cost] = getInfo(aIdx);
    % is it satisfied?
    if apod == destinationRoom + 1 ||...
            (apod == destinationRoom &&...
            apods(partner) == destinationRoom + 1)
        %disp(compose("%i (%c - %i) is satified",apod,type,aIdx))
        continue
    end
    % into destination from hall
    if apod < 7
        if ~any(apods==destinationRoom) && apods(partner) == (destinationRoom + 1) % entrance to room is clear and deeper in room is partner
            if ~cannotGet(apods,apod,destinationRoom)
                %disp(compose("%i (%c - %i) Move to destination %i",apod,type,aIdx,destinationRoom))
                newState = apods;
                newState(aIdx) = destinationRoom;
                %disp(visualiseApods(newState))
                newCost = numberOfSteps(apod,destinationRoom) * cost;% + heuristic(newState) - ch;
                %disp(visualiseApods(newState))
                costs = [costs;
                    newCost];
                neighbours = [neighbours;
                    newState];            else
                %disp(compose("%i (%c - %i) Blocked, cannot move to destination %i",apod,type,aIdx,destinationRoom))
            end

        elseif ~any(apods == destinationRoom) && ~any(apods == (destinationRoom+1))
            if ~cannotGet(apods,apod,destinationRoom)
                %disp(compose("%i (%c - %i) Move to destination %i",apod,type,aIdx,destinationRoom))
                newState = apods;
                newState(aIdx) = destinationRoom + 1;
                newCost = numberOfSteps(apod,destinationRoom + 1) * cost;% + heuristic(newState) - ch;
                %disp(visualiseApods(newState))
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
            newCost = numberOfSteps(apod,hIdx) * cost;% + heuristic(newState) - ch;
            %disp(visualiseApods(newState))
            %disp(visualiseApods(newState))
            costs = [costs;
                newCost];
            neighbours = [neighbours;
                newState];
        end
    end
    % return
end
end

function map = visualiseApods(apods)
map = (['...........'
    '##.#.#.#.##'
    ' #.#.#.#.# ']);
numMap = [0 1 nan 2 nan 3 nan 4 nan 5 6
    nan nan 7 nan 9 nan 11 nan 13 nan nan
    nan nan 8 nan 10 nan 12 nan 14 nan nan];
for idx = 1:numel(apods)
    map(apods(idx) == numMap) = getInfo(idx);
end
end

function bool = isBlockedInRoom(apods,idx)
bool = false;
tops = (7:2:13);
bottoms = tops + 1;
notTop = apods(idx) == bottoms;
if any(notTop)
    bool = any(ismember(apods,tops(notTop)));
end
end

function [type, idx, destinationRoom, partner,cost] = getInfo(number)
idx = ceil(number/2);
type = 'A' + idx - 1;
destinationRoom = 5 + idx * 2;

partner = number + (-1).^(number+1);
cost = 10^(idx-1);
end

function steps = numberOfSteps(from,to)
persistent cache
if isempty(cache)
    cache = nan(15);
end
steps = cache(from + 1, to + 1);
if isnan(steps)
    colMap = [0 1 3 5 7 9 10 2 2 4 4 6 6 8 8];
    depMap = [0 0 0 0 0 0  0 1 2 1 2 1 2 1 2];
    fc = colMap(from + 1); tc = colMap(to + 1);
    fd = depMap(from + 1); td = depMap(to + 1);
    depth = (fd + td) .* double(fc ~= tc);
    steps = depth + abs(fc - tc);
    cache(from + 1, to + 1) = steps;
end
end

function bool = cannotGet(apods,from,to)

colMap = [0 1 3 5 7 9 10 2 2 4 4 6 6 8 8];
fc = colMap(from + 1); tc = colMap(to + 1);
podsInHall = colMap(apods(apods < 7) + 1);
podsInHall(podsInHall == fc) = [];

bool = any(podsInHall >= min([fc tc]) & podsInHall <= max([fc tc]));
end

function key = encode8x15_fast(v)
weights = uint64([1 15 225 3375 50625 759375 11390625 170859375]);
key = sum(uint64(v(:).') .* weights);
end


