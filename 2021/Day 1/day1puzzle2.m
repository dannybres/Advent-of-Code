inputData = readmatrix("./input");
slidingWindowSize = 3;
sumOfThree = movsum(inputData,slidingWindowSize,Endpoints="discard");
day1puzzle2Answer = sum(diff(sumOfThree)>0)