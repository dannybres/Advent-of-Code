%% day14puzzle1 - Daniel Breslan - Advent Of Code 2019
day14puzzle1result = calculateOre(1) %#ok<NOPTS> 

function oreNeeded = calculateOre(fuel)
data = readlines("input.txt").split(" => ");
[~,e] = regexp(data,"([^0-9 =>,]+)", "tokens","match");
allEle = unique(horzcat(e{:}))';
t = table(allEle,zeros(numel(allEle),1),zeros(numel(allEle),1),...
    VariableNames=["ele","needed","produced"]);
t.needed(t.ele == "FUEL") = fuel;

while 1
    toMake = t(t.needed > t.produced,:);
    toMake = toMake(toMake.ele ~= "ORE",:);
    for idx = 1:height(toMake)
        toMakeRow = toMake(idx,:);
        if toMakeRow.ele == "ORE"
            if height(toMakeRow) == 1
                break
            end
            continue
        end
        needed = toMakeRow.needed - toMakeRow.produced;
        makes = data(data(:,2).contains(toMakeRow.ele),2).split(" ");
        makes = makes(1).double;
        ingredients = data(data(:,2).endsWith(" " + toMakeRow.ele),1)...
            .split(", ");
        reactionsNeeded = ceil(needed/makes);
        for iidx = 1:height(ingredients)
            thisIngredient = ingredients(iidx,:).split(" ")';
            t.needed(t.ele == thisIngredient(2)) = t.needed(t.ele ==...
                thisIngredient(2)) + thisIngredient(1).double *...
                reactionsNeeded;
        end
        t.produced(t.ele == toMakeRow.ele) = t.produced(t.ele == ...
            toMakeRow.ele) + makes * reactionsNeeded;
    end
    if isempty(toMake)
        break
    end
end
oreNeeded = t.needed(t.ele == "ORE");
end