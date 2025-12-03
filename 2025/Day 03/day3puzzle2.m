%% day3puzzle2 - Daniel Breslan - Advent Of Code 2025
data = readlines("input.txt").char() - '0';
n = 12;
r = nan(height(data),n);
for idx = 1:height(data)
    s = 1;
    for rIdx = 1:n
        r(idx,rIdx) = max(data(idx,s:end-n+rIdx));
        s = find(data(idx,s:end) == r(idx,rIdx),1) + s;
    end
end
sum(r .* 10.^(n-1:-1:0),'all')