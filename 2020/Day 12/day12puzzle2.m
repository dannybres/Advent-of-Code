%% day12puzzle2 - Daniel Breslan - Advent Of Code 2021
data = readlines("input.txt");
p=[0 0];
clc
% wp = [1 -10];
d = data.extractBefore(2);
n = data.extractAfter(1).double();

compass.F = [1 10];
compass.N = [1 0];
compass.E = [0 1];
compass.S = [-1 0];
compass.W = [0 -1];
ds = [compass.N; compass.E; compass.S; compass.W];

for idx = 1:numel(d)
    if d(idx) == "F"
        p = p + n(idx) * compass.(d(idx));
    elseif d(idx) == "R" || d(idx) == "L"
        spinFactor = [0 1; -1 0];
        if d(idx) == "L"
            spinFactor = -spinFactor;
        end
        compass.F = compass.F * spinFactor^(n(idx)/90);
    else
        compass.F = compass.F + n(idx) * compass.(d(idx));
    end
end

day12puzzle1result = sum(abs(p))

