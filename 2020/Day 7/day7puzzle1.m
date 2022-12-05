%% day7puzzle1 - Daniel Breslan - Advent Of Code 2020
data = readlines("input.txt");
data = data.replace(" contain",",").erase(" bags").erase(" bag");
data = data.erase(".").erase(", no other");
for idx = 1:10
    data = data.replace(string(idx),idx+",");
end

writematrix(data,'temp.csv',QuoteStrings=false);
t = readtable("temp.csv",ReadVariableNames=false,TextType="string");
writetable(t,"temp.csv");
t = readtable("temp.csv",TextType="string");

t = t(:,1:2:end);

lookingFor = "shiny gold";

lastFound = -1;
canHold = false(height(t),1);
while lastFound ~= sum(canHold)
    lastFound = sum(canHold);
    canHold = canHold | any(any(t{:,2:end} == permute(lookingFor,[3 2 1]),3),2);
    lookingFor = ["shiny gold";t{canHold,1}];
end
sum(canHold)