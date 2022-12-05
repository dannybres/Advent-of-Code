%% day8puzzle1 - Daniel Breslan - Advent Of Code 2021
data = readtable("input.txt",TextType="string", ...
    ReadVariableNames=false);
data = data(:,[1:10 12:end]);

data = data{:,11:end}.strlength;
data = data(:);
day8puzzle1result = sum(data == [2 3 4 7],"all")