%% day19puzzle1 - Daniel Breslan - Advent Of Code 2023
clc
data = readlines("input.txt");
m = data(1:find(data == "")-1);
m = m.extractBefore("}").split("{");
m = dictionary(m(:,1),m(:,2));
p = data((find(data == "")+1):end);

r = false(numel(p),1);
for idx = 1:numel(p)
    cp = p(idx).extractBetween("{","}").split([",","="]);
    d = dictionary(cp(1:2:end),cp(2:2:end).double);
    r(idx) = "A" == runMachine(m,d);
end

day19puzzle1result = ...
    sum(p(r).extract(digitsPattern).double(),'all') %#ok<NOPTS>

function nextWorkflow = runMachine(machine,ratings)
nextWorkflow = "in";
while ~(nextWorkflow == "A" || nextWorkflow == "R")
    ins = machine(nextWorkflow).split(",");
    for idx = 1:numel(ins)
        i = ins(idx);
        if i.contains("<")
            i = i.split(["<",":"]);
            if ratings(i(1)) < i(2).double
                nextWorkflow = i(3);
                break
            end
        elseif i.contains(">")
            i = i.split([">",":"]);
            if ratings(i(1)) > i(2).double
                nextWorkflow = i(3);
                break
            end
        else
            nextWorkflow = i;
        end
    end
end
end

