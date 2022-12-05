%% day4puzzle2 - Daniel Breslan - Advent Of Code 2019
data = "172851-675869";

data = data.split("-").double();
allNums = data(1):data(2);

% allNums = [112233,123444,111122]


ind = string(allNums').split("").double();
ind = ind(:,2:end-1);
dinf = diff(ind,1,2);

same = dinf == 0;

% Two adjacent digits are the same (like 22 in 122345).
sameidx = any(dinf == 0,2);

% Going from left to right, the digits never decrease; they only ever increase or stay the same (like 111123 or 135679).
incidx = all(dinf >= 0,2);

avalidpair = any(0 == conv2(same,[1 0 1],'same') & same,2);

day4puzzle1result = sum(avalidpair & incidx);
