%% Part 1
data = readlines("input.txt").split("");
data = double( data(:,2:end-1) );
sum(data(imregionalmin(data,4))+1)
