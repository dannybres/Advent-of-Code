data = readlines("input.txt");
buses = data(2).split(",");
buses(buses == "x") = "NaN";
buses = buses.double();

format long g

in = buses;

initial = max(in);
restFull = [in (0:numel(in)-1)'];
rest = restFull(~isnan(restFull(:,1)),:);

mods = rest(:,1);
t = rest(:,2);
t = mod(t,mods);
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