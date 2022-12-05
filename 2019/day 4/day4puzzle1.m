%% day4puzzle1 - Daniel Breslan - Advent Of Code 2019
data = "172851-675869";

data = data.split("-").double();
allNums = data(1):data(2);


ind = string(allNums').split("").double();
ind = ind(:,2:end-1);
dinf = diff(ind,1,2);

% Two adjacent digits are the same (like 22 in 122345).
sameidx = any(dinf == 0,2);

% Going from left to right, the digits never decrease; they only ever increase or stay the same (like 111123 or 135679).
incidx = all(dinf >= 0,2);

day4puzzle1result = sum(sameidx & incidx);
