%% day3puzzle2 - Daniel Breslan - Advent Of Code 2025
data = readlines("input.txt").char() - '0';
numberOfDigits = 12;
digits = nan(height(data),numberOfDigits);
for idx = 1:height(data)
    startIdx = 1;
    for rIdx = 1:numberOfDigits
        digits(idx,rIdx) = max(data(idx,startIdx:end-numberOfDigits+rIdx));
        startIdx = find(data(idx,startIdx:end) == ...
            digits(idx,rIdx),1) + startIdx;
    end
end
format longg
sum(digits .* 10.^(numberOfDigits-1:-1:0),'all')