%% day1puzzle2 - Daniel Breslan - Advent Of Code 2025
clc
data = readlines("input.txt");
dir = data.extract(1);
num = str2double(data.extractAfter(1));

dialLocation = 50;
counterOfZeroPasses = 0;

for idx = 1:numel(dir)
    st = dialLocation;
    if dir(idx) == "L"
        dialLocation = dialLocation - num(idx);
    else
        dialLocation = dialLocation + num(idx);
    end
    en = dialLocation;
    counterOfZeroPasses = counterOfZeroPasses + floor(abs(en)/100);
    if en < 1
        counterOfZeroPasses = counterOfZeroPasses + 1;
    end
    if st == 0 && en < 0
        counterOfZeroPasses = counterOfZeroPasses - 1;
    end
    dialLocation = mod(dialLocation,100);
end

day1puzzle2result = counterOfZeroPasses