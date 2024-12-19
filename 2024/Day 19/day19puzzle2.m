%% day19puzzle2 - Daniel Breslan - Advent Of Code 2024
data = readlines("input.txt");
t = data(1).split(", ");
d = data(3:end);
day19puzzle1result = 0;
day19puzzle2result = 0;
for idx = 1:numel(d)
    idx
    day19puzzle2result = day19puzzle2result + towelCombinations(d(idx),t);
end
day19puzzle2result

function number = towelCombinations(design,towels)
persistent cache
if isempty(cache)
    cache = configureDictionary("string","double");
elseif isKey(cache,design)
        number = cache(design);
        return
end
number = 0;
for t = towels'
    if design.endsWith(t)
        trimmedDesign = design.extractBefore(...
            strlength(design)-strlength(t)+1);
        if trimmedDesign == ""
            number = number + 1;
        else
            number = number + towelCombinations(trimmedDesign,towels);
        end
    end
end
cache(design) = number;
end