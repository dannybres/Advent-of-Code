%% day4puzzle2 - Daniel Breslan - Advent Of Code 2020

data = readlines("inputDemo.txt");
specialSeperator = "#!#!#!#";
data(data=="")= specialSeperator;
data = data.join(" ").split(specialSeperator);
data(data.extractAfter(data.strlength-1) == " ") = ...
    data(data.extractAfter(data.strlength-1) == " ").extractBefore(...
    data(data.extractAfter(data.strlength-1) == " ").strlength);
data(data.extractBefore(2) == " ") = ...
    data(data.extractBefore(2) == " ").extractAfter(...
    1);

for idx = 1:numel(data)
    in = data(idx);
    in = in.split(" ").split(":");
    for fidx = 1:size(in,1)
        out(idx).(in(fidx,1)) = in(fidx,2);
    end
end

pt = struct2table(out);
writetable(pt,'temp.csv');
opt = detectImportOptions("temp.csv");
opt.VariableTypes([1 2 4 5 8]) = {'string'};
pt = readtable('temp.csv',opt);
pt = removevars(pt,'cid');

isValid = array2table(true(size(pt)));
isValid.Properties.VariableNames = pt.Properties.VariableNames;


isValid.byr = pt.byr >= 1920 & pt.byr<=2002;
isValid.iyr = pt.iyr >= 2010 & pt.iyr<=2020;
isValid.eyr = pt.eyr >= 2020 & pt.eyr<=2030;

[mat,~,~] = regexp(pt.hgt, '(\d+)(cm|in)', 'match', ...
               'tokens', 'tokenExtents');
isValid.hgt(isValid.hgt) = ~cellfun(@isempty, mat)

hgtToCheck = pt.hgt(isValid.hgt)

unit = hgtToCheck.extractAfter(hgtToCheck.strlength-2);
value = double(hgtToCheck.extractBefore(hgtToCheck.strlength-1));
minHgt = ones(numel(hgtToCheck),1) * 150;
maxHgt = ones(numel(hgtToCheck),1) * 193;

minHgt(unit == "in") = 59;
maxHgt(unit == "in") = 76;

isValid.hgt(isValid.hgt) = value >= minHgt & value <= maxHgt;
[mat,tok,ext] = regexp(pt.hcl, '#[a-f 0-9]{6}', 'match', ...
'tokens', 'tokenExtents');
isValid.hcl =  ~cellfun(@isempty, mat);

acceptableHC = ["amb","blu","brn","gry","grn","hzl","oth"];
isValid.ecl = logical(sum((pt.ecl == acceptableHC)')');

isValid.pid = string(pt.pid).strlength==9;

day4puzzle2result = nnz(all(isValid{:,:}'))