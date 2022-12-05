%% day2puzzle2 - Daniel Breslan - Advent Of Code 2022
data = char(readlines("input.txt").erase(" "));
op = double(data(:,1)) - double('A');
res = double(data(:,2)) - double('X');

you = op;
you(res ==  0) = op(res ==  0) - 1;
you(res ==  2) = op(res ==  2) + 1;

you(you == 3) = 0;
you(you == -1) = 2;

day2puzzle2result = sum(you + 1) + (sum(diff([op you],1,2) == -2:2) * [6 0 3 6 0]')