%% day1puzzle2 - Daniel Breslan - Advent Of Code 2018
sequence = cumsum(repmat(readlines("input.txt").double(),3000,1)); 
% 3000 is a random large number!
[U, I] = unique(sequence, 'first');
x = 1:length(sequence);
x(I) = [];

day1puzzle2result = sequence(x(1)) %#ok<NOPTS> 
