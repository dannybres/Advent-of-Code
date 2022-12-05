%% day7puzzle2 - Daniel Breslan - Advent Of Code 2020
% read data in
data = readlines("input.txt");
data = data.replace(" contain",",").erase(" bags").erase(" bag").erase(".").erase(", no other");
for idx = 1:10, data = data.replace(string(idx),idx+","); end

writematrix(data,'temp.csv',QuoteStrings=false);
t = readtable("temp.csv",ReadVariableNames=false,TextType="string", ...
    NumHeaderLines=0,Delimiter=",");

% rearrange bag, numbers, content
t = t(:,[1 2:2:end 3:2:end]);

% getdetails of table
startOfMeta = width(t)+1;
startOfCount = 2;
startOfBags = 2 + (width(t)-1)/2;
numberOfBags = startOfBags - startOfCount - 1;

% set counts to 0 if NaN
counts = t{:,startOfCount:startOfCount+numberOfBags};
counts(isnan(counts)) = 0;
t{:,startOfCount:startOfCount+numberOfBags} = counts;

% make counts
meta = double(~ismissing(t{:,startOfBags:startOfBags+numberOfBags}));
meta(meta == 1) = NaN;
meta = [meta nan(height(t),2)];
tt = array2table(meta);
tt.Properties.VariableNames(1:end-2) = "Meta " + t.Properties.VariableNames(startOfBags:startOfBags+numberOfBags);
tt.Properties.VariableNames(end-1:end) = ["totalBags" "Done"];
t = [t tt];

%Process the bags
while any(isnan(t.Done))%for idx = 1:3
    t.totalBags = sum(t{:,startOfMeta:startOfMeta+numberOfBags} .* ...
        t{:,startOfCount:startOfCount+numberOfBags},2)+1;
    toDo = t(~isnan(t.totalBags) & isnan(t.Done),:);

    for hidx = 1:height(toDo)
        meta = t{:,startOfMeta:startOfMeta+numberOfBags};
        bags = t{:,startOfBags:startOfBags+numberOfBags};
        meta(bags == toDo.Var1(hidx)) = toDo.totalBags(hidx);
        t{:,startOfMeta:startOfMeta+numberOfBags} = meta;
        t.Done(t.Var1 == toDo.Var1(hidx)) = 1;
    end
end

% get result
day7puzzle2result = t.totalBags(t.Var1 == "shiny gold")-1 %#ok<NOPTS> 