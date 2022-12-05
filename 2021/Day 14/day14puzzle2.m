%% day14puzzle2 - Daniel Breslan - Advent Of Code 2021
data = readlines("input.txt");
line = data(1);
data = data(3:end).split(" -> ");

% set up table
command = data(:,1);
insert = data(:,2);
ind = command.extractBefore(2);
new1 = command.extractBefore(2) + insert;
new2 = insert + command.extractAfter(1);

% add initial line
ll = char(line);
initialPairs = string(ll((1:2) + (0:line.strlength-2)'));
count = sum(command == initialPairs',2);

% fucking linear algebra!!! (i think)
multiplier = double(new1' == command) + double(new2' == command);
count = multiplier^40 * count;

%sum it up
all = string(unique(char(command.join("")))).split("");
all = all(2:end-1)';
counting = double(ind == all)' * count + double(all == line.extractAfter(line.strlength-1))';

format long g
day14puzzle2result = max(counting) - min(counting)
format short