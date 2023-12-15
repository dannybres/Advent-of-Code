%% day15puzzle1 - Daniel Breslan - Advent Of Code 2023
% Determine the ASCII code for the current character of the string.
% Increase the current value by the ASCII code you just determined.
% Set the current value to itself multiplied by 17.
% Set the current value to the remainder of dividing itself by 256.
data = readlines("input.txt").split(",");
r = nan(numel(data),1);
for idx = 1:numel(data)
h = 0;
s = char(data(idx));
for c = s
    h = mod((h + double(c))*17,256);
end
r(idx) = h;
end
day15puzzle1result = sum(r)
