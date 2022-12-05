%% day8puzzle2 - Daniel Breslan - Advent Of Code 2020
clc
data = readlines("input.txt");
data = data.split(" ");
t = array2table(data);
t.Properties.VariableNames = ["ins" "num"];
t.num = double(t.num);

for idx = 1:height(t)
    if t.ins(idx) == "acc"
        continue
    end
    tt = t;
    if tt.ins(idx) == "nop"
        tt.ins(idx) = tt.ins(idx).replace("nop","jmp");
    else
        tt.ins(idx) = tt.ins(idx).replace("jmp","nop");
    end
    [day8puzzle1result, success] = runCode(tt);
    if success
        disp("found it!")
        break
    end
end
day8puzzle1result

function [out, success] = runCode(code)
nextIns = 1;
acc = 0;
done = [];
target = height(code) + 1;
success = false;
while true
    if target == nextIns
        success = true;
        break
    end
    if nextIns > height(code)
        break
    end
    if  any(nextIns == done)
        break
    end
    done = [done nextIns];
    if code.ins(nextIns) == "acc"
        acc = acc + code.num(nextIns);
        nextIns = nextIns + 1;
    elseif code.ins(nextIns) == "jmp"
        nextIns = nextIns + code.num(nextIns);
    else
        nextIns = nextIns + 1;
    end
end

out = acc;
end