%% day12puzzle1 - Daniel Breslan - Advent Of Code 2021
data = readlines("input.txt");
p=[0 0];
d = data.extractBefore(2);
n = data.extractAfter(1).double();

compass.F = [0 1];
compass.N = [1 0];
compass.E = [0 1];
compass.S = [-1 0];
compass.W = [0 -1];
ds = [compass.N; compass.E; compass.S; compass.W];

for idx = 1:numel(d)
    if d(idx) == "R" || d(idx) == "L"
        spinFactor = 1;
        if d(idx) == "R"
            spinFactor = -1;
        end
        normDir = circshift(ds, -(find(all(compass.F == ds,2))-1));
        turned = circshift(normDir,spinFactor * n(idx)/90);
        compass.F = turned(1,:);
        continue
    end
    p = p + n(idx) * compass.(d(idx));
end

day12puzzle1result = sum(abs(p))

