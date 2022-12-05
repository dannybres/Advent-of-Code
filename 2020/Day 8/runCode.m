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

