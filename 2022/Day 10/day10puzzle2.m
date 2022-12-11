%% day10puzzle2 - Daniel Breslan - Advent Of Code 2022
tic
data = readlines("input.txt").replace(["noop" "addx "],["1 0" "2 "])...
    .split(" ").double(); % load as 2 cols (# cycles and register change)
data = cumsum(data); 
data(:,2) = data(:,2) + 2; % add 2 - matlab is 1 based and to centre sprite

a = [(1:240)' nan(240,1)]; % make a list of all cycles
data = [data; a(~ismember(a(:,1),data(:,1)),:)]; % remove cycles in data
[~,b] = sort(data(:,1)); %sort in order of cycles
data = data(b,:);
data(1,2) = 2; % set first register to 2 - ML is 1 based and centre sprite
data(:,2) = fillmissing(data(:,2),"previous"); % copy missing regs down

data = [data [2;data(1:end-1,2)]]; % make start of cycle register location
data(:,1) = mod(data(:,1),40); % max is 40 as per row
data(data(:,1) == 0,1) = 40; % mod makes 40 == 0, change back to 40

data(:,4) = data(:,1) >= data(:,3) - 1 & data(:,1) <= data(:,3) + 1; % see
% if cycle is +/-1 from register location (covered by sprite)
res = repmat(' ',40,6); % make the output as blank
res(data(1:40*6,4) == 1) = '#'; % fill in the #, where needed
day10puzzle2result = reshape(res,40,6)' %#ok<NOPTS> % resize
toc