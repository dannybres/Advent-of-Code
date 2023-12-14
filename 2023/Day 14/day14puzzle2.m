%% day14puzzle1 - Daniel Breslan - Advent Of Code 2023
tic
% profile on
m = double(char(readlines("input.txt")));
m(m==79) = 1;
m(m==46) = 0;
m(m==35) = nan;

n = 1000000000; % num cycles
tn = 200; % test cycles to establish period
r = nan(tn,1); % test results
for idx = 1:tn % loop for test
    for d = 1:4 % loop each dir for a cycle
        m = tilt(m); % tilt it
        m = rot90(m,-1); % rotate clockwise
    end
    [row,~] = find(m == 1); % calculate N force
    r(idx) = sum(size(m,1) - row + 1);
end
period = tn - find(r(end) == r(1:end-2),1,"last"); % establish period
day14puzzle2result = r(tn-period + mod(n-tn,period)) %#ok<NOPTS> % N load
% profile viewer
toc