%% day14puzzle1 - Daniel Breslan - Advent Of Code 2023
m = char(readlines("input.txt"));
m = tilt(m,'N'); % tilt it
[r,~] = find(m == 'O');
day14puzzle1result = sum(size(m,1) - r + 1) %#ok<NOPTS>