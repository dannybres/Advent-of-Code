%% day11puzzle1 - Daniel Breslan - Advent Of Code 2024
clc
stones = "125 17";
stones = "0 5601550 3914 852 50706 68 6 645371"
stones = double(stones.split(" "))'
for b = 1:75
    b
for idx = numel(stones):-1:1
    value = stones(idx);
    if value == 0
        stones(idx) = 1;
    elseif mod(strlength(string(value)),2) == 0
        before = stones(1:idx-1);
        after = stones((idx + 1):end);
        textValue = string(value);
        middle = double([textValue.extractBefore(1+strlength(textValue)/2)...
            textValue.extractAfter(strlength(textValue)/2)]);
        stones = [before middle after];
    else
        stones(idx) = stones(idx) * 2024;
    end
end
end
numel(stones)
day11puzzle1result = 0;
