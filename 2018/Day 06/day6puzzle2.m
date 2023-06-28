%% day6puzzle2 - Daniel Breslan - Advent Of Code 2018
data = readlines("input.txt").split(", ").double();
t = array2table([(1:50)' data], VariableNames=["num","r","c"]);

res = zeros(400,400);

for r = 1:400
    for c = 1:400
        res(r,c) = sum(abs(t.r - r) + abs(t.c - c)); % calc total dist
    end
end

day6puzzle2result = sum(res < 10000,'all') %#ok<NOPTS>
