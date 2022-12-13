%% day13puzzle2 - Daniel Breslan - Advent Of Code 2022
dividerPackets = ["[[2]]";"[[6]]"];
data = [readlines("input.txt"); dividerPackets];
data = data.replace(["[","]"],["{","}"]);
data(data == "") = [];

for idx = numel(data)-1:-1:1
    for b = 1:idx
        if ~checkMe(data,b,b+1)
            temp = data(b);
            data(b) = data(b+1);
            data(b+1) = temp;
        end
    end
end
day13puzzle2result = prod(find(any(data' == dividerPackets...
    .replace(["[","]"],["{","}"]))))

function correctOrder = checkMe(data, Lidx, Ridx)
    correctOrder = testMe(eval(data{Lidx}),eval(data{Ridx}));
end

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