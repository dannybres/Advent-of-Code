%% day13puzzle1 - Daniel Breslan - Advent Of Code 2022
clc
data = readlines("inputDemo.txt");
data(3:3:end) = [];
data = data.replace(["[","]"],["{","}"]);

n = 1;
rightOrder = false(numel(data)/2,1);
for idx = 1:2:2*n%numel(data)
    L = eval(data{idx});
    R = eval(data{idx+1});
    rightOrder(idx) = testMe(L,R);
end

rightOrder

function rightOrder = testMe(L,R)
rightOrder = false;

for idx = 1:max(numel(L),numel(R))
    Lc = L{idx};
    Rc = R{idx};
    if Lc < Rc
        rightOrder = true;
        return
    elseif Lc > Rc
        return
    end
end
end