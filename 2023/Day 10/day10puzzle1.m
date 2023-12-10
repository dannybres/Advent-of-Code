%% day10puzzle1 - Daniel Breslan - Advent Of Code 2023
data = char(readlines("input.txt"));
nei = [0 -1;-1 0;0 1;1 0];
[r,c] = ind2sub(size(data),find(data == 'S'));
p = nan(numel(data),2);
p(1,:) = [r,c];
delu = dictionary((1:4)',['LF-';'F7|';'7J-';'JL|']);
nelu = dictionary(('JL7F|-')',[12;23;14;34;24;13]);

ni = 2;
while true
    r = p(ni-1,1); c = p(ni-1,2);
    n = [(1:4)', [r c] + nei]; % all options
    n((any(n < 1,2) | ...
        n(:,2) > size(data,1) | n(:,3) > size(data,2)),:) = []; % exclude data off map
    if ni > 3 % exclude prior step
        n(n(:,2) == p(ni-2,1) & n(:,3) == p(ni-2,2),:) = [];
    end
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
        p(ni,:) = next;
        ni = ni + 1;
    end
end
day10puzzle1result = (ni-1)/2 %#ok<NOPTS> 