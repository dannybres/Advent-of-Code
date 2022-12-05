%% day1puzzle2 - Daniel Breslan - Advent Of Code 2022
data = readlines("input.txt").double()
day1puzzle1result = sum(maxk(accumarray(cumsum(isnan(data))+1,...
    data,[],@(x) sum(x,"omitnan")),3))
