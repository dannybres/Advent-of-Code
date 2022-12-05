%% day9puzzle1 - Daniel Breslan - Advent Of Code 2021
data = double(readlines("input.txt").split(""));
data = data(:,2:end-1);
day9puzzle1result = sum(data(padarray(diff(data')'>0,[0 1],true,'post') & padarray(diff(data')'<=0,[0 1],true,'pre') & padarray(diff(data)>0,[1 0],true,'post') & padarray(diff(data)<=0,[1 0],true,'pre'))+1) %#ok<NOPTS> 