%% day7puzzle2 - Daniel Breslan - Advent Of Code 2020
% read data in
data = readlines("input.txt");
data = data.replace(" contain",",").erase(" bags").erase(" bag").erase(".").erase(", no other");
for idx = 1:10, data = data.replace(string(idx),idx+","); end

writematrix(data,'temp.csv',QuoteStrings=false);
t = readtable("temp.csv",ReadVariableNames=false,TextType="string", ...
    NumHeaderLines=0,Delimiter=",");

% rearrange bag, numbers, content
colours = t{:,1};
counts = t{:,2:2:end};
bags = t{:,3:2:end};

% set counts to 0 if NaN
counts(isnan(counts)) = 0;

% make counts
meta = double(~ismissing(bags));
meta(meta == 1) = NaN;
totalBags = nan(height(t),1);

%Process the bagsnp
while any(isnan(totalBags))%for idx = 1:3
    totalBags = sum(meta .* counts,2)+1;
    toDo = find(~isnan(totalBags));
    for hidx = toDo'
        meta(bags == colours(hidx)) = totalBags(hidx);
    end
end

% get result
day7puzzle2result = totalBags(colours == "shiny gold")-1 %#ok<NOPTS> 