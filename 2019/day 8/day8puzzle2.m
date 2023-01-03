%% day8puzzle2 - Daniel Breslan - Advent Of Code 2019
w = 25;
h = 6;

data = readlines("input.txt").split("");
data = data(2:end-1).double;
data = data((reshape(1:numel(data),w*h,[]))');

idx = data ~= 2;
idx = idx .* (1:size(idx, 1)).';
idx(idx == 0) = NaN;
idx = min(idx, [], 1);

pixels = data(sub2ind(size(data),idx,1:width(data)));
pixels = reshape(pixels,w,h);
imshow(repelem(pixels'==1,10,10))