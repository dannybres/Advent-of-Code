mods = [67;7;59;61]
t = (0:3)'
rem = [0; mods(2:end) - t(2:end)]
N = prod(mods)./mods
for idx = 1:numel(N)
    go = 1;
    n = 1;
    multiplierForThis = mod(N(idx),mods(idx));
    while go
        if mod(n*multiplierForThis,mods(idx)) == 1 
            x(idx) = n;
            go = false;
        end
        n = n + 1
    end

end

bNx = rem .* N .* x'

mod(sum(bNx),prod(mods))