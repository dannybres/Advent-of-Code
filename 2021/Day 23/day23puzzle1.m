clc
profile on
data = readlines("inputDemo.txt");
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

%%
clc
heuristic(apods)
%%
% state;
% apods=[8    14     7     6     0    12    10     4];
% visualiseApods(apods)
% neighbours = findNeighbours(0,apods);
% for nidx = 1:height(neighbours)
%
%     visualiseApods(neighbours(nidx,2:end))
% end
%
% a = [];
% for idx = 1:8
%     [type, ii, destinationRoom, partner,cost] = getInfo(idx);
%     a = [a;type, ii, destinationRoom, partner,cost];
% end
% %disp(a)
%

heapq = py.importlib.import_module('heapq');
pq = py.list();

heapq.heappush(pq, py.tuple({heuristic(state), py.list(state)}));

si = repmat({15},1,8);
visited = false(si{:});
idx = 0;
while ~isempty(pq)
    idx = idx + 1;

    % for idx = 1:5000
    state = heapq.heappop(pq);
    currentCost = state{1};
    if rand() < 0.001
        disp(compose("Item %i for cost %i",idx,currentCost))
    end
    % if rand() < 0.001
    %     visualiseApods(apods)
    % end
    apods = double(state{2});
    if all([sort(apods(1:2)), sort(apods(3:4)), sort(apods(5:6)), sort(apods(7:8))] == 7:14)
        % currentCost
        break
    end
    vi = num2cell(apods+1);
    if visited(vi{:})
        continue
    end
    visited(vi{:}) = true;
    neighbours = findNeighbours(currentCost,apods);
    if idx > 1e4
        % %     visualiseApods(apods)
        % %     for nidx = 1:height(neighbours)
        % %
        % %         visualiseApods(neighbours(nidx,2:end))
        % %     end
        % %     1
        % break
    end
    for nidx = 1:height(neighbours)
        heapq.heappush(pq, py.tuple({neighbours(nidx,1), py.list(neighbours(nidx,2:end))}));
    end

    % pyItems = py.list( ...
    %     arrayfun(@(i) ...
    %         py.tuple({ ...
    %             neighbours(i,1), ...
    %             py.list(neighbours(i,2:end)) ...
    %         }), ...
    %         1:height(neighbours), ...
    %         'UniformOutput', false) ...
    % );
    %
    % pq.extend(pyItems);
    % heapq.heapify(pq);


    % length(pq)
end
disp(compose("Item %i for cost %i",idx,currentCost))
% currentCost
profile viewer
function neighbours = findNeighbours(currentCost,apods)
% visualiseApods(apods)
neighbours = [];
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
        if ~any(ismember(apods,destinationRoom)) && apods(partner) == (destinationRoom + 1) % entrance to room is clear and deeper in room is partner
            if ~cannotGet(apods,apod,destinationRoom)
                %disp(compose("%i (%c - %i) Move to destination %i",apod,type,aIdx,destinationRoom))
                newState = apods;
                newState(aIdx) = destinationRoom;
                %disp(visualiseApods(newState))
                newCost = currentCost + numberOfSteps(apod,destinationRoom) * cost + heuristic(newState) - heuristic(apods);
                %disp(visualiseApods(newState))
                neighbours = [neighbours; newCost, newState];
            else
                %disp(compose("%i (%c - %i) Blocked, cannot move to destination %i",apod,type,aIdx,destinationRoom))
            end

        elseif ~any(ismember(apods,destinationRoom)) && ~any(ismember(apods,destinationRoom+1))
            if ~cannotGet(apods,apod,destinationRoom)
                %disp(compose("%i (%c - %i) Move to destination %i",apod,type,aIdx,destinationRoom))
                newState = apods;
                newState(aIdx) = destinationRoom + 1;
                newCost = currentCost + numberOfSteps(apod,destinationRoom + 1) * cost  + heuristic(newState) - heuristic(apods);
                %disp(visualiseApods(newState))
                neighbours = [neighbours; newCost, newState];
            else
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
            newCost = currentCost + numberOfSteps(apod,hIdx) * cost  + heuristic(newState) - heuristic(apods);
                %disp(visualiseApods(newState))
            %disp(visualiseApods(newState))
            neighbours = [neighbours; newCost, newState];
        end
    end
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
% persistent cache
% if isempty(cache)
%     cache = nan(15);
% end
% steps = cache(from + 1, to + 1);
% if isnan(steps)
    colMap = [0 1 3 5 7 9 10 2 2 4 4 6 6 8 8];
    depMap = [0 0 0 0 0 0  0 1 2 1 2 1 2 1 2];
    fc = colMap(from + 1); tc = colMap(to + 1);
    fd = depMap(from + 1); td = depMap(to + 1);
    depth = (fd + td) .* double(fc ~= tc);
    steps = depth + abs(fc - tc);
    % cache(from + 1, to + 1) = steps;
% end
end

function bool = cannotGet(apods,from,to)

colMap = [0 1 3 5 7 9 10 2 2 4 4 6 6 8 8];
fc = colMap(from + 1); tc = colMap(to + 1);
locs = sort([fc tc]);
podsInHall = colMap(apods(apods < 7) + 1);
podsInHall(podsInHall == fc) = [];

bool = any(podsInHall >= min(locs) & podsInHall <= max(locs));
end

function value = heuristic(apods)
value = 0;
for idx = 1:numel(apods)
    [~, ~, destinationRoom, ~,cost] = getInfo(idx);
    value = min([numberOfSteps(apods(idx),destinationRoom + 1), numberOfSteps(apods(idx),destinationRoom)]) * cost;
end
end

function out = setState(state)
   out = [encode4(state(1:4)) encode4(state(5:8))];
end

function out = getState(state)
   out = [decode4(state(1)) decode4(state(2))];
end

function u = encode4(a)
    % a : 1x4 vector, each element in [0,14]
    u = uint64(a(1)) ...
      + bitshift(uint64(a(2)), 4) ...
      + bitshift(uint64(a(3)), 8) ...
      + bitshift(uint64(a(4)), 12);
end

function a = decode4(u)
    a = zeros(1,4,'uint8');
    a(1) = bitand(u, uint64(15));
    a(2) = bitand(bitshift(u, -4),  uint64(15));
    a(3) = bitand(bitshift(u, -8),  uint64(15));
    a(4) = bitand(bitshift(u, -12), uint64(15));
end