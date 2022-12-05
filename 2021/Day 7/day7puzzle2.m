%% day7puzzle2 - Daniel Breslan - Advent Of Code 2021
data = readmatrix("input.txt");
relation = @(position) sum((abs(data - position').^2+ ...
    abs(data - position'))/2,2)';
day7puzzle2result = relation(round(fminsearch(relation,median(data))))
