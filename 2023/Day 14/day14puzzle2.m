%% day14puzzle1 - Daniel Breslan - Advent Of Code 2023
m = char(readlines("input.txt"));
n = 1000000000; % num cycles
tn = 200; % test cycles to establish period
r = nan(tn,1); % test results
for idx = 1:tn % loop for test
    for d = 'NWSE' % loop each dir for a cycle
        m = tilt(m,d); % tilt it
    end
    [row,~] = find(m == 'O'); % calculate N force
    r(idx) = sum(size(m,1) - row + 1);
end
period = tn - find(r(end) == r(1:end-2),1,"last"); % establish period
day14puzzle2result = r(tn-period + mod(n-tn,period)) %#ok<NOPTS> % N load