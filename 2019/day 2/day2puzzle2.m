%% day2puzzle1 - Daniel Breslan - Advent Of Code 2019
dat = readlines("input.txt").split(",").double();
ogDat = dat;
for noun = 0:99
    for verb = 0:99
        dat = ogDat;
        % change vals
        dat(2) = noun;
        dat(3) = verb;

        % trip before 99 in position 1
        endIdx = find(dat(1:4:end) == 99);
        endIdx = 4 * (endIdx(1)-1);
        prodat = dat(1:endIdx);

        % all numbers = memory
        % position is address e.g. 1st is address 0
        % 1st in 4 group is an instruction
        % 2nd to 4th are parameters

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
        if dat(1) == 19690720
            break
        end
    end
    if dat(1) == 19690720
        break
    end
end

day2puzzle1result = 100 * noun + verb
