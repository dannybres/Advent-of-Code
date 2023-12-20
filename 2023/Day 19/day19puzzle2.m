%% day19puzzle1 - Daniel Breslan - Advent Of Code 2023
clc
data = readlines("input.txt");
m = data(1:find(data == "")-1);
m = m.extractBefore("}").split("{");
rules = cell(height(m),1);
m = dictionary(m(:,1),m(:,2));
t = array2table(repmat([1 4e3],4,1),...
    RowNames=["x","m","a","s"],...
    VariableNames=["min","max"]);

day19puzzle2result = count(m,t) %#ok<NOPTS>

function total = count(workflows,ranges,name)
    if nargin < 3
        name = "in";
    end

    if name == "R"
        total = 0;
        return
    elseif name == "A"
        total = prod(diff(ranges.Variables,1,2)+1);
        return
    end
    workflow = workflows(name).split(",");

    total = 0;
    doFallBack = true;
    for idx = 1:numel(workflow) - 1
        w = workflow(idx).split(":");
        key = w(1).extract(1);
        cmp = w(1).extract(2);
        value = w(1).extractAfter(2).double;
        destination = w(2);
        range = ranges{key,:};
        if cmp == "<"
            T = [range(1) min(value-1, range(2))];
            F = [max(value,range(1)) range(2)];
        else
            T = [max(value+1, range(1)) range(2)];
            F = [range(1) min(value, range(2))];
        end
        if T(1) <= T(2)
            copy = ranges;
            copy{key,:} = T;
            total = total + count(workflows,copy,destination);
        end
        if F(1) <= F(2)
            ranges{key,:} = F;
        else
            doFallBack = false;
            break
        end
    end
    if doFallBack
        total = total + count(workflows,ranges,workflow(end));
    end
end