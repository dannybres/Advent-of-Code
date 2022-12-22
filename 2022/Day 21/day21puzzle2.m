%% day21puzzle2 - Daniel Breslan - Advent Of Code 2022
data = readlines("input.txt").split(": ");

nums = data(strlength(data(:,2))< 8,:);
equa = data(strlength(data(:,2))> 8,:);
funlu = dictionary(["+","-","*","/"],{@(x) x(1)+x(2),@(x) x(1)-x(2), ...
    @(x) x(1)*x(2),@(x) x(1)/x(2)});

monkeys = dictionary(nums(:,1), nums(:,2).double());
monkeys("humn") = [];

equa = data(strlength(data(:,2))> 8,:);
lastNum = nan;
while true % Calculate what we can
    needed = [equa(:,2).extractBefore(5) equa(:,2).extractAfter(7)];
    solvable = all(ismember(needed,monkeys.keys),2);
    canbesolved = equa(solvable,:);
    funs = funlu(canbesolved(:,2).extract(6));
    for idx = 1:height(canbesolved)
        fun = funs{idx};
        monkeys(canbesolved(idx,1)) = fun(monkeys([canbesolved(idx,2)...
            .extractBefore(5) canbesolved(idx,2).extractAfter(7)]));
    end
    equa = equa(~solvable,:);
    if height(equa) == lastNum
        break
    end
    lastNum = height(equa);
end

toRep = needed(ismember(needed,monkeys.keys)); % add results to equations
with = monkeys(toRep);
equa = equa.replace(toRep,string(with));

rootDetails = equa(equa(:,1) == "root",2).split(" + "); % get the target
rootIdx = cellfun(@isempty,regexp(rootDetails, "[a-z]{4}"));
target = rootDetails(rootIdx).double;
targetMonkey = rootDetails(~rootIdx);

equa = equa.replace(targetMonkey,string(target)); % add the result to eqn

s = str2sym(equa(:,1) + " = " + equa(:,2));
results = solve(s);

day21puzzle2result = results.humn