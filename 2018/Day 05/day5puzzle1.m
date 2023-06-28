%% day5puzzle1 - Daniel Breslan - Advent Of Code 2018
data = double(char(readlines("input.txt")));

idx = find(abs(diff(data)) == 32,1); % 32 ascii # diff = diff pol,same type
while ~isempty(idx) % loop until none
    data(idx:idx+1) = []; % remove it
    idx = find(abs(diff(data)) == 32,1); % look for more
end

day5puzzle1result = numel(data) %#ok<NOPTS> 
