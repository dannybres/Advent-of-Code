%% day14puzzle1 - Daniel Breslan - Advent Of Code 2019
data = readlines("inputDemo.txt").split(" => ")

[~,e] = regexp(data,"([^0-9 =>,]+)", "tokens","match");

all = unique(horzcat(e{:}))'

t = table(all,zeros(numel(all),1),zeros(numel(all),1),VariableNames=["ele","needed","produced"])

t.needed(t.ele == "FUEL") = 1;

toMake = t(t.needed > t.produced,:);

for idx = 1:height(toMake)
    toMakeRow = toMake(idx,:);
    needed = toMakeRow.needed - toMakeRow.produced;
    makes = data(data(:,2).contains(toMakeRow.ele),2).split(" ");
    makes = makes(1).double;
    ingredients = data(data(:,2).contains(toMakeRow.ele),1).split(", ");

    reactionsNeeded = ceil(needed/makes);

    for iidx = 1:height(ingredients)
        thisIngredient = ingredients(iidx,:).split(" ");
        t.
    end
end


day14puzzle1result = 0;
