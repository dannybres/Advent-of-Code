%% day4puzzle1 - Daniel Breslan - Advent Of Code 2020

data = readlines("input.txt");
specialSeperator = "#!#!#!#";
data(data=="")= specialSeperator;
data = data.join(" ").split(specialSeperator);
data(data.extractAfter(data.strlength-1) == " ") = ...
    data(data.extractAfter(data.strlength-1) == " ").extractBefore(...
    data(data.extractAfter(data.strlength-1) == " ").strlength);
data(data.extractBefore(2) == " ") = ...
    data(data.extractBefore(2) == " ").extractAfter(...
    1);

needed = ["byr","iyr","eyr","hgt","hcl","ecl","pid","cid"];
result = false(numel(data),size(needed,2));
for idx = 1:numel(data)
    in = data(idx);
    in = in.split(" ").split(":");
    result(idx,:) = any(in(:,1)==needed);
end
day4puzzle1result = nnz(all(result(:,1:end-1)'))



