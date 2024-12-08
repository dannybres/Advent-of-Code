%% day5puzzle2 - Daniel Breslan - Advent Of Code 2024
data = readlines("input.txt");
seperator = find(data == "");
rules = data(1:seperator-1);
manuals = data(seperator+1:end);

rules = rules.split("|").double();
valid = true(1,numel(manuals));
for idx = 1:numel(manuals)
    pages = manuals(idx).split(",").double();
    valid(idx) = isValid(pages,rules);
end
day5puzzle1result = valueOfManuals(manuals(valid));

invalidManuals = manuals(~valid);
day5puzzle2result = 0;
for idx = 1:numel(invalidManuals)
    candidatePages = invalidManuals(idx).split(",").double()';
    applicableRules = unique(rules(sum(candidatePages == rules(:,1),2) ...
        & sum(candidatePages == rules(:,2),2),:),"rows");
    [G,n] = findgroups(applicableRules(:,1));
    day5puzzle2result = day5puzzle2result + n(groupcounts(G) ==  ...
        max(groupcounts(G))/2);
end
day5puzzle1result
day5puzzle2result

function validity = isValid(pages,rules)
    for r = 1:height(rules)
        if all(sum(pages == rules(r,:)))
            if find(rules(r,1) == pages) > find(rules(r,2) == pages)
                validity = false;
                return
            end
        end
    end
    validity = true;
end

function summation = valueOfManuals(manuals)
arguments
    manuals(1,:)
end
summation = 0;
    for m = manuals
        pages = m.split(",").double();
        summation = summation + pages(ceil(numel(pages)/2));
    end
end
