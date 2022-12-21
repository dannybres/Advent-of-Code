%% day20puzzle2 - Daniel Breslan - Advent Of Code 2022
data = readlines("input.txt").double;
data = data * 811589153;
% data = [10 1 2 3 4]';
data = [(1:numel(data))' data];

for n = 1:10
for idx = 1:height(data)
    currentPosition = find(data(:,1) == idx);
    number = data(data(:,1) == idx,2);
    if number == 0
        continue
    end
    newPosition = currentPosition + number;
    if newPosition < 1
        newPosition = height(data) + mod(newPosition,1-height(data)) - 1; 
    elseif newPosition == 1
        newPosition = height(data);
    elseif newPosition > height(data)
        newPosition = mod(newPosition,height(data)-1);
        if newPosition == 0
            newPosition = height(data)-1;
        end
    end
    if numel(newPosition) > 2
        1
    end
    toAdd = data(data(:,1) == idx,:);
    data(data(:,1) == idx,:) = [];

    pre = data(1:newPosition-1,:);
    post = data(newPosition:end,:);
    
    data = [pre; toAdd; post];
end
end
finSeq = data(:,2)';
zeroPos = find(finSeq == 0);

day20puzzle2result = sum(finSeq(mod((1:3)*1e3+zeroPos, ...
    numel(finSeq)))) %#ok<NOPTS> 