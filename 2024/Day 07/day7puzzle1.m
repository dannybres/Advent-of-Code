%% day7puzzle1 - Daniel Breslan - Advent Of Code 2024
data = readlines("input.txt");
day7puzzle1result = 0;
for idx = 1:numel(data)
    d = data(idx);
    target = d.extractBefore(":").double();
    elements = d.extractAfter(": ").split(" ").double();
    day7puzzle1result = day7puzzle1result + target * dfs(target,elements);
end
day7puzzle1result

function possible = dfs(target,elements)
    if numel(elements) == 2 % final two elements
        if prod(elements) == target || sum(elements) == target %|| ...
            % string(elements).join("").double == target
            possible = true;
        else
            possible = false;
        end
    else
        possible = false;
        for idx = 1:2%3
            if possible
                break
            end
            switch idx
                case 1 % +
                    newElements = elements;
                    newElements(2) = sum(newElements(1:2));
                    newElements(1) = [];
                    possible = dfs(target,newElements);
                case 2 % * 
                    newElements = elements;
                    newElements(2) = prod(newElements(1:2));
                    newElements(1) = [];
                    possible = dfs(target,newElements);
                % case 3 % |
                %     newElements = elements;
                %     newElements(2) = string(newElements(1:2))...
                %         .join("").double;
                %     newElements(1) = [];
                %     possible = dfs(target,newElements);
            end
        end
    end
end