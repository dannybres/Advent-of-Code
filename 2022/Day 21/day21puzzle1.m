%% day21puzzle1 - Daniel Breslan - Advent Of Code 2022
data = readlines("input.txt").split(": ");

nums = data(strlength(data(:,2))< 8,:);
equa = data(strlength(data(:,2))> 8,:);

funlu = dictionary(["+","-","*","/"],{@(x) x(1)+x(2),@(x) x(1)-x(2), ...
    @(x) x(1)*x(2),@(x) x(1)/x(2)});

monkeys = dictionary(nums(:,1), nums(:,2).double());

while ~isKey(monkeys,"root")
    needed = [equa(:,2).extractBefore(5) equa(:,2).extractAfter(7)];
    solvable = all(ismember(needed,monkeys.keys),2);
    canbesolved = equa(solvable,:);
    monkeys([canbesolved(:,2).extractBefore(5) canbesolved(:,2)...
        .extractAfter(7)]);
    funs = funlu(canbesolved(:,2).extract(6));
    for idx = 1:height(canbesolved)
    	fun = funs{idx};
        monkeys(canbesolved(idx,1)) = fun(monkeys([canbesolved(idx,2)...
            .extractBefore(5) canbesolved(idx,2).extractAfter(7)]));
    end
    equa = equa(~solvable,:);
end
day21puzzle1result = monkeys("root")