%% day22puzzle2 - Daniel Breslan - Advent Of Code 2024
% Slow-ish solution!!! Needs some optimisation

buyerSecretNumber = readlines("input.txt").double;
buyerSecretNumber = [buyerSecretNumber nan(height(buyerSecretNumber),2000)];

for widx = 1:2000
    buyerSecretNumber(:,widx+1) = nextNumber(buyerSecretNumber(:,widx));
end
bananaValue = mod(buyerSecretNumber,10);
delta = diff(bananaValue,1,2);

cache = configureDictionary("string","double");
for hidx = 1:height(delta)
    seen = false(19,19,19,19);
    for widx = 1:width(delta)-4
        seq = delta(hidx,widx:widx+3);
        key = string(seq).join(",");
        if seen(seq(1) + 10, seq(2) + 10, seq(3) + 10, seq(4) + 10)
            continue
        end
        seen(seq(1) + 10, seq(2) + 10, seq(3) + 10, seq(4) + 10) = true;
        if ~isKey(cache,key)
            cache(key) = 0;
        end
        cache(key) = cache(key) + bananaValue(hidx,widx + 4);
    end
end
max(cache.values)

function sn = nextNumber(sn)
sn = mod(bitxor(sn,sn * 64),16777216);
sn = mod(bitxor(sn,floor(sn / 32)),16777216);
sn = mod(bitxor(sn,sn * 2048),16777216);
end
