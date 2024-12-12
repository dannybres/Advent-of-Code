%% day11puzzle2 - Daniel Breslan - Advent Of Code 2024
tic
stones = "0 5601550 3914 852 50706 68 6 645371"
stones = double(stones.split(" "))';
day11puzzle2result = 0;
n = 75;
for s = stones
    day11puzzle2result = day11puzzle2result + dfs(s,n);
end
format longg
day11puzzle2result
toc

function numStones = dfs(stone, remaining)
persistent cache
if ~remaining
    numStones = 1;
    return
end
if isempty(cache)
    for idx = 1:remaining
        cache{idx} = configureDictionary("double","double");
    end
else
    if isKey(cache{remaining},stone) & ~isempty(cache{remaining})
        numStones = cache{remaining}(stone);
        return
    end
end

if stone == 0
    numStones = dfs(1,remaining-1);
elseif mod(strlength(string(stone)),2) == 0
    textValue = string(stone);
    stones = double([textValue.extractBefore(1+strlength(textValue)/2)...
        textValue.extractAfter(strlength(textValue)/2)]);
    numStones = 0;
    for idx = 1:2
        numStones = numStones + dfs(stones(idx),remaining-1);
    end
else
    numStones = dfs(stone * 2024,remaining-1);
end
cache{remaining}(stone) = numStones;
end
