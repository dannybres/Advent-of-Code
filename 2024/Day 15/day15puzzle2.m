%% day15puzzle2 - Daniel Breslan - Advent Of Code 2024
data = readlines("input.txt");
i = find(data == "");
m = char(data(1:i-1));
dirs = char(data(i:end).join(""));

m = repelem(m,1,2);
l = find(m == '@',1,"last");
m(l) = '.';
m = char(string(m).replace("OO","[]"));

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
        if path(2) == '.'
            path = step(path);
            m(1:r,c) = rot90(path);
        else
            m = moveUp(m);
        end
    else
        path = rot90(m(r:end,c));
        if path(2) == '.'
            path = step(path);
            m(r:end,c) = rot90(path,3);
        else
            mm = moveUp(flipud(m));
            m = flipud(mm);
        end
    end
end
m;
[r,c] = find(m == '[');
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

function m = moveUp(m)
    [r,c] = find(m == '@');
    q = [r c];
    toMove = [];
    while q
        toMove = [toMove; q(1,:)]; %#ok<*AGROW>
        nr = q(1,1) - 1; nc = q(1,2);
        q(1,:) = [];
        if m(nr,nc) == '#', return, end
        if m(nr,nc) == '['
            q = [q; nr,nc;nr,nc+1];
        elseif m(nr,nc) == ']'
            q = [q; nr,nc;nr,nc-1];
        end
    end
    a = m(sub2ind(size(m),toMove(:,1),toMove(:,2)));
    m(sub2ind(size(m),toMove(:,1),toMove(:,2))) = '.';
    m(sub2ind(size(m),toMove(:,1)-1,toMove(:,2))) = a;
end