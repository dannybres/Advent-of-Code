%% day14puzzle2 - Daniel Breslan - Advent Of Code 2024
data = readlines("input.txt").erase("p=").replace(" v=",",").split(",").double();
w = 101;
h = 103;
%% min safety factor - with a tree formed, some pixels will be grouped together, product of values (that sum to same value) is lowest when unevenly spaced (random spacing will give largest safety factors as (0.25 x n)^4).
per = reshape([true true; ...
    true false; ...
    false true; ...
    false false]',1 ...
    ,2,[]);
minsf = inf;
minstep = nan;
for n = 1:(w*h)
    l = data(:,1:2) + n * data(:,3:4);
    l = mod(l,[w h]);
    l = l(~any(l == [floor(w/2) floor(h/2)],2),:);
    l = l < [floor(w/2) floor(h/2)];
    num = squeeze(sum(all(l == per,2)));
    sf = prod(num);
    if sf < minsf
        minsf = sf;
        minstep = n;
    end
end
minstep

%% all robots in unique locations, possible solution that work - AoC things
for n = 1:(w*h)
    l = data(:,1:2) + n * data(:,3:4);
    l = mod(l,[w h]);
    if height(unique(l,"rows")) == height(data)
        allSeperate = n
        break
    end
end

%% minVariance in x and y, tree will group some values, so variance will drop
x = mod(data(:,1) + (1:w*h) .* data(:,3),w);
y = mod(data(:,2) + (1:w*h) .* data(:,4),h);
minVstep = find(min(var(x)) == var(x) & min(var(y)) == var(y))