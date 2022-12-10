%% day10puzzle2 - Daniel Breslan - Advent Of Code 2022
data = readlines("input.txt").replace(["noop" "addx "],["1 0" "2 "])...
    .split(" ").double();
data(:,1) = cumsum(data(:,1));

sprPos = 2;

r1 = repmat(' ',1,40*6);

for idx = 1:max(data(:,1))
    cStrPos =  sprPos + floor(idx/40) * 40;
    if idx >= cStrPos - 1 && idx <= cStrPos + 1
        r1(idx) = '#';
    end
    if ~isempty(data(data(:,1) == idx,2))
        sprPos = sprPos + data(data(:,1) == idx,2);
    end
end

reshape(r1(1:40*6),40,6)'
