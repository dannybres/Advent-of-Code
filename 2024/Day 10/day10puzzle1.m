%% day10puzzle1 - Daniel Breslan - Advent Of Code 2024
m = double(char(readlines("input.txt"))) - double('0');

[r,c] = find(m == 0);
day10puzzle1result = 0;
day10puzzle2result = 0;
for idx = 1:numel(r)
    trailHead = [r(idx),c(idx)];
    nineReachable = search(m,trailHead);
    uniqNineReachable = unique(nineReachable,"rows");
    day10puzzle1result = day10puzzle1result + height(uniqNineReachable);
    day10puzzle2result = day10puzzle2result + height(nineReachable);
end
day10puzzle1result %#ok<NOPTS>
day10puzzle2result %#ok<NOPTS>

function found = search(m,from)
startingAltitude = m(from(1),from(2));
found = [];
for dir = [-1 0;1 0;0 -1;0 1]'
    to = from + dir';
    if ~any(to < 1 | to > height(m))
        if startingAltitude == 8 && m(to(1),to(2)) == 9
            found = [found;to]; %#ok<AGROW>
        elseif startingAltitude + 1 == m(to(1),to(2))
            found = [found; search(m,to)]; %#ok<AGROW>
        end
    end
end
end