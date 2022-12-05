%% day3puzzle2 - Daniel Breslan - Advent Of Code 2022
data = readlines("input.txt");

badge = strings(1,numel(data)/3);
for idx = 1:3:numel(data)
temp = intersect(intersect(data(idx).split(""),data(idx+1).split("")),...
    data(idx+2).split(""));
badge((idx - 1) / 3 + 1) = temp(end);
end

day3puzzle2result = sum(convertToPriority(badge')) %#ok<NOPTS> 


function out = convertToPriority(in)
out = double(char(in));
out(out<double('a')) = out(out<double('a')) - double('A') + 27;
out(out>double('a')) = out(out>double('a')) - double('a') + 1;
end