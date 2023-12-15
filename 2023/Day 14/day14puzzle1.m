%% day14puzzle1 - Daniel Breslan - Advent Of Code 2023
m = double(char(readlines("input.txt")));
m(m==79) = 1;
m(m==46) = 0;
m(m==35) = nan;
m = tilt(m); % tilt it
[r,~] = find(m == 1);
day14puzzle1result = sum(size(m,1) - r + 1) %#ok<NOPTS>