%% day20puzzle1 - Daniel Breslan - Advent Of Code 2021
profile on
data = readlines("inputDemo.txt");
algo = char(data(1)) == '#';

img = char(data(3:end)) == '#';

for i = 1:50
    if mod(i,2) == 0
        padval = 1;
    else
        padval = 0;
    end
    img = padarray(img, [2 2], padval, 'both');
    img = nlfilter(img, [3 3], @(sub_img) algoEnhance(sub_img, algo));
    img = img(2:end-1, 2:end-1);
end

sum(img, 'all')

profile viewer
function y = algoEnhance(x, algo)
    binVal = bin2dec(num2str( reshape(x', 1, []) ));
    y = algo(binVal + 1);
end
