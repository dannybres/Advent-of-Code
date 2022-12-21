%% day21puzzle2 - Daniel Breslan - Advent Of Code 2022
data = readlines("input.txt").split(": ");
nums = data(strlength(data(:,2))< 8,:);
equa = data(strlength(data(:,2))> 8,:);

funlu = dictionary(["+","-","*","/"],{@(x) x(1)+x(2),@(x) x(1)-x(2), ...
    @(x) x(1)*x(2),@(x) x(1)/x(2)});
humn = 0;
passesTest = false;
while ~passesTest
    if mod(humn,10) == 0
        disp(humn)
    end
    monkeys = dictionary(nums(:,1), nums(:,2).double());
    equa = data(strlength(data(:,2))> 8,:);
    humn = humn + 1;
    monkeys("humn") = humn;
    while true
        needed = [equa(:,2).extractBefore(5) equa(:,2).extractAfter(7)];
        solvable = all(ismember(needed,monkeys.keys),2);
        canbesolved = equa(solvable,:);
        if any(canbesolved(:,1) == "root")
            passesTest = diff(monkeys([canbesolved(canbesolved(:,1) == "root",2).extractBefore(5) canbesolved(canbesolved(:,1) == "root",2)...
                .extractAfter(7)])) == 0;
            break
        end
        funs = funlu(canbesolved(:,2).extract(6));
        for idx = 1:height(canbesolved)
        	fun = funs{idx};
            monkeys(canbesolved(idx,1)) = fun(monkeys([canbesolved(idx,2)...
                .extractBefore(5) canbesolved(idx,2).extractAfter(7)]));
        end
        equa = equa(~solvable,:);
    end
end


day21puzzle2result = monkeys("humn")