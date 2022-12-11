%% day11puzzle1 - Daniel Breslan - Advent Of Code 2022
data = readlines("input.txt").join(";").split(";;");
[~,tok,~] = regexp(data,"Monkey (\d+):;\s+Starting items:" + ...
    " ([^;]+);\s+Operation: new = old ([^;]+);\s+Test: ([^;]+)" + ...
    ";\s+If true: throw to monkey (\d+);    If false: throw to " + ...
    "monkey (\d+)", 'match', ...
    'tokens', 'tokenExtents');
a = 1;

monkeys = monkey.empty(numel(tok),0);

tok = cellfun(@(x) string(x{:}), tok, 'UniformOutput', false);
for idx = 1:numel(tok)
    monkeys(idx) = monkey(tok{idx});
end

n = 20;
for ridx = 1:n
    for midx = 1:numel(monkeys)
        for iidx = 1:numel(monkeys(midx).items)
        	[location, worryLevel] = monkeys(midx).locationToSendItem(...
                modder,3);
            monkeys(location).addItem(worryLevel);
        end
    end
end

activity = sort(vertcat(monkeys.inspected));

prod(activity(end-1:end))

day11puzzle1result = prod(activity(end-1:end)) %#ok<NOPTS> 