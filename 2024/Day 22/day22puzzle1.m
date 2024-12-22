%% day22puzzle1 - Daniel Breslan - Advent Of Code 2024
buyerSecretNumber = readlines("input.txt").double;
for idx = 1:2000
    buyerSecretNumber = nextNumber(buyerSecretNumber);
end
day22puzzle1Result = sum(buyerSecretNumber)

function sn = nextNumber(sn)
sn = mod(bitxor(sn,sn * 64),16777216);
sn = mod(bitxor(sn,floor(sn / 32)),16777216);
sn = mod(bitxor(sn,sn * 2048),16777216);
end