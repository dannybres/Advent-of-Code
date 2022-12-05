%% day2puzzle1 - Daniel Breslan - Advent Of Code 2019
dat = readlines("input.txt").split(",").double();

% change vals
dat(2) = 12;
dat(3) = 2;

% trip before 99 in position 1
endIdx = find(dat(1:4:end) == 99);
endIdx = 4 * (endIdx(1)-1);
prodat = dat(1:endIdx);

% reshape and loop actions
prodat = reshape(prodat,4,[])';
for idx = 1:size(prodat,1)
    datEle = prodat(idx,:);
    datEle(2:end) = datEle(2:end) + 1;
    fun = @prod;
    if datEle(1) == 1
        fun = @sum;
    end
    dat(datEle(4)) = fun(dat(datEle(2:3)));
end

    
day2puzzle1result = dat(1)
