%% day19puzzle1 - Daniel Breslan - Advent Of Code 2024
data = readlines("input.txt");
t = data(1).split(", ");
d = data(3:end);
day19puzzle1result = 0;
day19puzzle1result = 0;
for idx = 1:numel(d)
    day19puzzle1result = day19puzzle1result + isPossible(d(idx),t);
end
day19puzzle1result

function possible = isPossible(design,towels)
persistent cache
if isempty(cache)
    cache = configureDictionary("string","logical");
elseif isKey(cache,design)
        possible = cache(design);
        return
end
possible = false;
for t = towels'
    if design.endsWith(t)
        trimmedDesign = design.extractBefore(...
            strlength(design)-strlength(t)+1);
        if trimmedDesign == ""
            possible = true;
            break
        else
            possible = isPossible(trimmedDesign,towels);
        end
        if possible
            break
        end
    end
end
cache(design) = possible;
end