%% day9puzzle1 - Daniel Breslan - Advent Of Code 2024
data = char(readlines("input.txt"));
storage = nan(1,sum(str2double(string(data'))));
fill = 1;
for idx = 1:numel(data)
    element = str2double(data(idx));
    if mod(idx,2)
        storage(fill:fill + element - 1) = idx/2 - 0.5;
    end
    fill = fill + element;
end
fullStorage = storage;
noGap = storage(~isnan(storage));
idxToFill = isnan(storage);
storage(idxToFill) = fliplr(noGap(end-nnz(idxToFill)+1:end));
storage = storage(1:end - nnz(idxToFill));
day9puzzle1result = sum(storage' .* (0:numel(storage)-1)')

for move = (idx/2 + 0.5):-1:1
    startOfMoveGroup = find(fullStorage == move,1);
    idxToMove = storage == move;
    sizeToMove = nnz(idxToMove);
    subStorage = fullStorage(1:startOfMoveGroup);
    availableSlots = true(1,numel(subStorage) - sizeToMove + 1);
    for idx = 1:sizeToMove
        availableSlots = availableSlots & isnan(subStorage(idx:(numel(subStorage) - sizeToMove + idx)));
    end
    if ~nnz(availableSlots)
        continue
    end
    startOfLocation = find(availableSlots,1);
    locationToGoTo = startOfLocation:startOfLocation + sizeToMove - 1;
    fullStorage(fullStorage == move) = nan;
    fullStorage(locationToGoTo) = move;
end
day9puzzle2result = sum(fullStorage' .* (0:numel(fullStorage)-1)',1,"omitmissing")