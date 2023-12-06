%% day16puzzle2 - Daniel Breslan - Advent Of Code 2018
clc
clear
data = readlines("input.txt");
data = data(data ~= "");
endOfText = find(data.contains("After"),1,"last");
test = data(endOfText + 1:end).extract(digitsPattern).double;
data = data(1:endOfText).extract(digitsPattern).double;

% find matches
funs = {@mulr @muli @addr @addi, @banr, @bani, @borr, @bori, ...
    @setr, @seti, @gtir, @gtri, @gtrr, @eqir, @eqri, @eqrr};
orfun = nan(size(funs));
matches = nan(height(data)/3,numel(funs));
for didx = 1:3:height(data)
    res = nan(numel(funs),4);
    for idx = 1:numel(funs)
        res(idx,:) = funs{idx}(data(didx+1,:),data(didx,:));
    end
    matches((didx+2)/3,:) = ismember(res,data(didx+2,:),"rows")';
end

%workout the opcode order
instr = data(2:3:end,:);
while any(isnan(orfun))
    subm = matches(sum(matches,2) == 1,:);
    funidxs = find(sum(subm)~=0);
    for ffidx = 1:numel(funidxs)
        funidx = funidxs(ffidx);
        submidx = sum(matches,2) == 1;
        submidx = submidx & matches(:,funidx) == 1;
        subinst = instr(submidx,:);
        orfun(subinst(1)+1) = funidx;
        matches(:,funidx) = 0;
    end
end

%execute code
funs = dictionary(0:15,funs(orfun));
data = zeros(1,4);
for idx = 1:height(test)
    fun = funs(test(idx,1));
    fun = fun{:};
    data = fun(test(idx,:),data);
end
day16puzzle2result = data(1) %#ok<NOPTS> 