%% day13puzzle1 - Daniel Breslan - Advent Of Code 2022
data = readlines("input.txt").replace(["[","]"],["{","}"]);
data(3:3:end) = [];
rightOrder = false(numel(data)/2,1);
for idx = 1:2:numel(data)
    rightOrder(1+(idx-1)/2) = testMe(eval(data{idx}),eval(data{idx+1}));
end
day13puzzle1result = sum(find(rightOrder == 1)) %#ok<NOPTS> 

function [rightOrder, stopRunning] = testMe(L,R)
rightOrder = false; stopRunning = false; % initialise vars, if either true,
% it stops

for idx = 1:max(numel(L),numel(R))
    % check if list has ran out
    if idx > numel(L)
        rightOrder = true;
        return
    elseif idx > numel(R)
        stopRunning = true;
        return
    end
    % if a list, open it else L or R is the L/Rcurrent (Lc & Rc)
    if ~isnumeric(L)
        Lc = L{idx};
    else
        Lc = L;
    end
    if ~isnumeric(R)
        Rc = R{idx};
    else
        Rc = R;
    end

    if class(Lc) == "cell" || class(Rc) == "cell"
        % if one is a list run recursively run this func
        [rightOrder, stopRunning] = testMe(Lc,Rc);
        if rightOrder || stopRunning,return,end
    elseif isscalar(Lc) && isscalar(Rc) && isnumeric(Lc) && isnumeric(Rc)
        % both are 2 numbers, check the comparison
        if Lc < Rc
            rightOrder = true; return
        elseif Lc > Rc
            stopRunning = true; return
        end
    end
end
end