%% day22puzzle2 - Daniel Breslan - Advent Of Code 2024
% Super slow solution!!! Needs optimisation

buyerSecretNumber = readlines("inputDemo.txt").double;
buyerSecretNumber = [buyerSecretNumber nan(height(buyerSecretNumber),2000)];

for widx = 1:2000
    buyerSecretNumber(:,widx+1) = nextNumber(buyerSecretNumber(:,widx));
end
bananaValue = mod(buyerSecretNumber,10);
delta = diff(bananaValue,1,2);
day22puzzle1result = 0;
seen = false(19,19,19,19);
qidx = 0;
profile on
for hidx = 1:height(delta)
    for widx = 1:width(delta)-3
        seq = delta(hidx,widx:widx+3);
        if seen(seq(1) + 10, seq(2) + 10, seq(3) + 10, seq(4) + 10)
            continue
        end
        seen(seq(1) + 10, seq(2) + 10, seq(3) + 10, seq(4) + 10) = true;
        day22puzzle1result = max(day22puzzle1result,mostBanana(bananaValue,delta,seq));
    end
end
day22puzzle1result

function sn = nextNumber(sn)
sn = mod(bitxor(sn,sn * 64),16777216);
sn = mod(bitxor(sn,floor(sn / 32)),16777216);
sn = mod(bitxor(sn,sn * 2048),16777216);
end

function total = mostBanana(bananaValue,delta,seq)
total = 0;
for hidx = 1:height(delta)
    widx = strfind(delta(hidx,:), seq);
    if widx
        bv = bananaValue(hidx,widx(1)+4);
        total = total + bv;
        continue
    end
end
end