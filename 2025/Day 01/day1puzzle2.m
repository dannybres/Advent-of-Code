%% day1puzzle2 - Daniel Breslan - Advent Of Code 2025
clc
data = readlines("input.txt");
dir = data.extract(1);
num = str2double(data.extractAfter(1));

d = 50;
c = 0;

for idx = 1:numel(dir)
    st = d;
    if dir(idx) == "L"
        d = d - num(idx);
    else
        d = d + num(idx);
    end
    en = d;
    c = c + floor(abs(en)/100);
    if en < 1
        c = c + 1;
    end
    if st == 0 && en < 0
        c = c - 1;
    end
    d = mod(d,100);
end

day1puzzle1result = c