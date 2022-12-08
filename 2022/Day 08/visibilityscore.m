%% day8puzzle1 - Daniel Breslan - Advent Of Code 2022
data = readlines("input.txt").split("").double;

data = data(:,2:end-1);

isVisible = zeros(size(data));

for r = 2:size(data,1)-1
    for c = 2:size(data,2)-1
        isVisible(r,c) =...
            all(data(r,1:c-1) < data(r,c)) +...
            all(data(r,c+1:end) < data(r,c)) +...
            all(data(1:r-1,c) < data(r,c)) +...
            all(data(r+1:end,c) < data(r,c));
    end
end

day8puzzle1result = sum(isVisible,'all') %#ok<NOPTS> 

%% graphic
f = figure();
imshow(repelem(isVisible,5,5)./max(isVisible,[],"all"))
saveas(f, 'visibletreeswithnmberofsightlines.png')