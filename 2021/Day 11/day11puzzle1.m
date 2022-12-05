%% day11puzzle1 - Daniel Breslan - Advent Of Code 2020
data = readlines("input.txt");
data = data.split("");
data = double(data(:,2:end-1));

flashes = 0;
while true
    data = data + 1;
    shouldFlash = data > 9;
    hasFlashed = false(size(data));
    while any(shouldFlash,"all")
        data = data + conv2(shouldFlash,ones(3,3),"same");
        hasFlashed = hasFlashed | shouldFlash;
        shouldFlash = data > 9 & ~hasFlashed;
    end
    flashes = flashes + 1;
    data(data > 9) = 0;
    if sum(data,"all") == 0
        break
    end
end
data
flashes
