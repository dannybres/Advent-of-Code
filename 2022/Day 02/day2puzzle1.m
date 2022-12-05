%% day2puzzle1 - Daniel Breslan - Advent Of Code 2022
data = char(readlines("input.txt").erase(" "));
op = double(data(:,1)) - double('A');
you = double(data(:,2)) - double('X');

day2puzzle1result = sum(you + 1) + (sum(diff([op you],1,2) == -2:2)...
    * [6 0 3 6 0]')

