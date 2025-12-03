%% day3puzzle1 - Daniel Breslan - Advent Of Code 2025
data = readlines("input.txt").char() - '0';
numberOfDigits = 2;
digits = nan(height(data),numberOfDigits);
for idx = 1:height(data)
    startIdx = 1;
    for rIdx = 1:numberOfDigits
        [digits(idx,rIdx),maxIdx] = max(data(idx,startIdx:end-numberOfDigits+rIdx));
        startIdx = maxIdx + startIdx;
    end
end
format longg
sum(digits .* 10.^(numberOfDigits-1:-1:0),'all')