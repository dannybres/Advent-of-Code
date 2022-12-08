%% day8puzzle2 - Daniel Breslan - Advent Of Code 2022
data = readlines("input.txt").split("").double;

data = data(:,2:end-1);

scenicScore = zeros(size(data));

for r = 2:size(data,1)-1
    for c = 2:size(data,2)-1
        up = processView(data(r-1:-1:1,c)' >= data(r,c));
        down = processView(data(r+1:end,c)' >= data(r,c));
        left = processView(data(r,c-1:-1:1) >= data(r,c));
        right = processView(data(r,c+1:end) >= data(r,c));
        
        scenicScore(r,c) = up * down * left * right;
    end
end

day8puzzle2result = max(scenicScore(:)) %#ok<NOPTS> 

%% graphic
f = figure();
imshow(repelem(scenicScore,5,5) ./ max(scenicScore,[],"all"))
saveas(f, 'scenicScore.png')

function out = processView(in)
    if sum(in) == 0
        out = numel(in);
        return
    end
    out = find(in,1);
end

