%% day15puzzle1 - Daniel Breslan - Advent Of Code 2024
data = readlines("input.txt");
i = find(data == "");
m = char(data(1:i-1));
dirs = char(data(i:end).join(""));

for idx = 1:numel(dirs)
    dir = dirs(idx);
    [r,c] = find(m == '@');
    if dir == '<'
        path = fliplr(m(r,1:c));
        path = step(path);
        m(r,1:c) = fliplr(path);
    elseif dir == '>'
        path = m(r,c:end);
        path = step(path);
        m(r,c:end) = path;
    elseif dir == '^'
        path = rot90(m(1:r,c),3);
        path = step(path);
        m(1:r,c) = rot90(path);
    else
        path = rot90(m(r:end,c));
        path = step(path);
        m(r:end,c) = rot90(path,3);
    end
end

[r,c] = find(m == 'O');
day15puzzle1result = sum((r-1) * 100 + c-1)


function path = step(path)
if ~any(path == '.'), return, end
fsidx = find(path == '.',1);
wallidx = find(path == '#',1);
if fsidx < wallidx
    path(fsidx) = [];
    path = ['.' path];
end
end