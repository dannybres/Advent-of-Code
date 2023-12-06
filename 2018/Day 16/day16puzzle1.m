%% day16puzzle1 - Daniel Breslan - Advent Of Code 2018
data = readlines("input.txt");
data = data(data ~= "");
endOfText = find(data.contains("After"),1,"last");

data = data(1:endOfText).extract(digitsPattern).double;
funs = {@mulr @muli @addr @addi, @banr, @bani, @borr, @bori, ...
    @setr, @seti, @gtir, @gtri, @gtrr, @eqir, @eqri, @eqrr};

matches = nan(height(data)/3,1);
for didx = 1:3:height(data)
    res = nan(numel(funs),4);
    for idx = 1:numel(funs)
        res(idx,:) = funs{idx}(data(didx+1,:),data(didx,:));
    end
    matches((didx+2)/3) = sum(ismember(res,data(didx+2,:),"rows"));
end
day16puzzle1result = sum(matches>=3) %#ok<NOPTS> 