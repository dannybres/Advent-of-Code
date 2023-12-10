%% day10puzzle1 - Daniel Breslan - Advent Of Code 2023
clc
data = char(readlines("input.txt"));
nei = [0 -1;-1 0;0 1;1 0];
[r,c] = ind2sub(size(data),find(data == 'S'));
p = [r,c];
delu = dictionary((1:4)',['LF-';'F7|';'7J-';'JL|']);
nelu = dictionary(('JL7F|-')',[12;23;14;34;24;13]);

% run = true;
while true
    r = p(end,1); c = p(end,2);
    n = [(1:4)', [r c] + nei]; % all options
    n((any(n < 1,2) | ...
        n(:,2) > size(data,1) | n(:,3) > size(data,2)) | ...
        ismember(n(:,2:end),p,'rows'),:) = []; % exclude off data, or back over path
    i = [n(:,1), sub2ind(size(data),n(:,2),n(:,3))]; % add next cell idx column and get index
    current = data(r,c); % get current location square
    i = i(any(data(i(:,2)) == char(delu(i(:,1))),2));% check destinations are ok to enter
    if isempty(i)
        break
    end
    if current ~= 'S' % remove non options, based on current, e.g. F can only go R or D
        allowed = string(nelu(current)).split("").double;
        allowed = allowed(2:3);
        i = i(any(i(:,1) == allowed',2),:);
    end
    if height(i) > 1 && current ~= 'S'
        error("many options")
    end
    if isempty(i)
        break
    else
        next = [r c] + nei(i(1),:);
        p = [p;next]; %#ok<AGROW>
    end
end
p = p(1:ni-1,:);
[x,y] = meshgrid(1:height(data));
[in,on] = inpolygon(x,y,p(:,1),p(:,2));
day10puzzle2result = sum(in,"all") - sum(on,"all")