%% day16puzzle1 - Daniel Breslan - Advent Of Code 2015
data = readlines("input.txt").split("").double;
data = data(2:end-1)';
factors = zeros(numel(data),numel(data));
base = [0 1 0 -1];
n = 100;
for phase = 1:n
    for idx = 1:height(factors)
        tmp = repmat(repelem(base,1,idx),1,ceil((numel(data)+1) / (4*idx)));
    	factors(idx,:) = tmp(2:1+numel(data));
    end
    data = mod(abs(sum(repmat(data,numel(data),1) .* factors,2)),10)';
end

day16puzzle1result = string(data(1:8)).join("")
