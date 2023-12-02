%% day2puzzle1 - Daniel Breslan - Advent Of Code 2023
data = readlines("input.txt");
day2puzzle1result = sum(find(arrayfun(@gamePossible,data)))

function out = gamePossible(in)
    game = in.split([": ",", ","; "]).split(" ");
    ball = game(2:end,2);
    count = game(2:end,1).double;
    out = ~any(count - (ball.extractBefore(2) == ["r","g","b"]) ...
        * (0:2)' > 12);
end