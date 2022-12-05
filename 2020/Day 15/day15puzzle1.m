clc
n = 30000000;

ip = "7,14,0,17,11,1,2";
% ip = "0,3,6";
ip = ip.split(",").double;

a = containers.Map(ip,1:numel(ip));
new = true
gap = 0
for idx = numel(ip) + 1:n
    if new
        gap = idx - a(0);
        new = false;
        a(0) = idx;
    else
        if isKey(a,gap)
            oldVal = a(gap);
            a(gap) = idx;
            gap = idx - oldVal;
        else
            a(gap) = idx;
            new = true;
        end
    end
end

q = cell2mat([a.keys' a.values']);
q(q(:,2) == n,1)