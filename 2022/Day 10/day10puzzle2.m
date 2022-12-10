%% day10puzzle2 - Daniel Breslan - Advent Of Code 2022
data = readlines("input.txt").replace(["noop" "addx "],["1 0" "2 "])...
    .split(" ").double(); % load as 2 cols (# cycles and register change)
data = cumsum(data); 
data(:,2) = data(:,2) + 2; % add 2 - matlab is 1 based and to centre sprite

data = array2table(data,VariableNames=["cycle","endreg"]); % tablulate data
a = table((1:40*6)',VariableNames="cycle"); % Table of all cycles
t = outerjoin(a,data,"RightVariables","endreg"); % join the data to all cyc
t.endreg(1) = 2; % fist register is 2
t.endreg = fillmissing(t.endreg,'previous'); % fill missing to move registe
% location to all cycles
t = t.Variables; % top using table, not needed now.

t = [t [2;t(1:end-1,2)]]; % make start of cycle register location
t(:,1) = mod(t(:,1),40); % max is 40 as per row
t(t(:,1) == 0,1) = 40; % mod makes 40 == 0, change back to 40

t(:,4) = t(:,1) >= t(:,3) - 1 & t(:,1) <= t(:,3) + 1; % see if cycle is +/-
% 1 from register location (civered by sprite)
res = repmat(' ',40,6); % make the output as blank
res(t(1:40*6,4) == 1) = '#'; % fill in the #, where needed
day10puzzle2result = reshape(res,40,6)' %#ok<NOPTS> % resize


