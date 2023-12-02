%% day2puzzle2 - Daniel Breslan - Advent Of Code 2023
data = readlines("input.txt");
day2puzzle1result = sum(arrayfun(@gamePower,data)) %#ok<NOPTS> 

function out = gamePower(in)
    game = in.split([": ",", ","; "]).split(" ");
    out = prod(max((game(2:end,2).extractBefore(2) == ["r","g","b"])' ...
        .* repmat(game(2:end,1).double',3,1),[],2));
end