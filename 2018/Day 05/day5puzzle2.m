%% day5puzzle2 - Daniel Breslan - Advent Of Code 2018
data = double(char(readlines("input.txt")));

toRemove = unique(data(data<double('a')));

minimumPolymer = Inf;

for ridx = toRemove
    char(ridx)
    rdata = data;
    rdata(rdata == ridx) = [];
    rdata(rdata == (ridx + 32)) = [];
    idx = find(abs(diff(rdata)) == 32,1); % 32 ascii # diff = diff pol,same type
    while ~isempty(idx) % loop until none
        rdata(idx:idx+1) = []; % remove it
        idx = find(abs(diff(rdata)) == 32,1); % look for more
    end
    minimumPolymer = min(minimumPolymer, numel(rdata));
end

day5puzzle2result = minimumPolymer %#ok<NOPTS>
