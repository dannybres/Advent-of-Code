data = readlines("input.txt");
% data(2) = "17,x,13,19"
buses = data(2).split(",");
buses(buses == "x") = "NaN";
buses = buses.double();

format long g

in = buses;

initial = max(in);
restFull = [in (0:numel(in)-1)'];
rest = restFull(~isnan(restFull(:,1)),:);
buses = rest(:,1);
times = rest(:,2);
times = mod(times,buses);

mods = buses;
rem = [0; buses(2:end) - times(2:end)];
restFull = [[repmat(NaN,20,1) (-20:-1)']; restFull];
restFull = [restFull nan(length(restFull),numel(buses))];
findStart = find(restFull(:,1) == 23)

restFull(findStart:end,3:end) = mod(rem' + (0:length(restFull) -findStart)',buses')

restFull(~isnan(restFull(:,1)),:)
