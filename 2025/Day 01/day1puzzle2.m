%% day1puzzle2 - Daniel Breslan - Advent Of Code 2025
data = readlines("input.txt");
dir = data.extract(1);
num = str2double(data.extractAfter(1));
num(dir  == "L") =  -num(dir  == "L");

startingVal = 50;

startVal = [startingVal;mod(startingVal + cumsum(num(1:end-1)),100)];

clicksToNext = startVal;
clicksToNext(num > 0) = 100 - clicksToNext(num > 0);
clicksToNext(clicksToNext == 0) = 100;

day1puzzle2result = sum(floor((abs(num) - clicksToNext) ./ 100) + 1)