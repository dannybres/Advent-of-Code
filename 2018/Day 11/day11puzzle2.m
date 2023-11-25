%% day11puzzle2 - Daniel Breslan - Advent Of Code 2018
sn = 5791;
maxSoFar = 0;
m = powerLevel(sn);
for sizeOfSq = 1:300
    kernel = ones(sizeOfSq);
    result = conv2(m, kernel, 'same');
    maxSquare = max(result,[],"all");
    if maxSquare > maxSoFar
        maxSoFar = maxSquare;
        sizeOfMax = sizeOfSq;
        [x,y] = ind2sub(size(m),find(result == maxSquare));
    end
end
day11puzzle1result = compose("%i,%i,%i",y-sizeOfMax/2+1,x-sizeOfMax/2+1,sizeOfMax) %#ok<NOPTS>