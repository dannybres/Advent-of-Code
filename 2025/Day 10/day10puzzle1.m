%% day10puzzle1 - Daniel Breslan - Advent Of Code 2025
data = readlines("input.txt");
day10puzzle1result = 0;

for dataIdx = 1:numel(data)
    machineInfo = data(dataIdx).split(" ");

    target = char(machineInfo(1).extractAfter(1)...
        .extractBefore(strlength(machineInfo(1))-1)) == '#';

    buttonOutputs = false(numel(machineInfo) - 2, numel(target));
    for idx = 2:numel(machineInfo) -1
        buttonOutputs(idx-1,machineInfo(idx)...
            .extract(digitsPattern).double + 1) = true;
    end
    
    pressOptions = dec2bin(1:(2^height(buttonOutputs)-1)) == '1';
    [~,so] = sort(sum(pressOptions,2));
    pressOptions = pressOptions(so,:);

    for idx = 1:height(pressOptions)
        if all(mod(sum(pressOptions(idx,:)' .* buttonOutputs),2) == target)
            break
        end
    end

    day10puzzle1result = day10puzzle1result + nnz(pressOptions(idx,:));
end
day10puzzle1result