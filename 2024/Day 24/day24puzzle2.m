%% day24puzzle1 - Daniel Breslan - Advent Of Code 2024
clc
data = readlines("input.txt");
blIdx = find(data == "");
registers = data(1:blIdx-1).split(": ");
gates = data(blIdx+1:end).split(" ");
gates(:,4) = [];
registers = dictionary(registers(:,1),registers(:,2).double);
sw = ["z39" "kdd";"dqr" "z33";"shh" "z21"]
for idx = sw'
    idx
gates(gates(:,4) == idx(1) | gates(:,4) == idx(2),4) = flipud(gates(gates(:,4) == idx(1) | gates(:,4) == idx(2),4));
end
k = registers.keys;
xk = sort(k(k.startsWith('x')),"descend");
yk = sort(k(k.startsWith('y')),"descend");
zk = sort(k(k.startsWith('z')),"descend");

d = digraph;
for idx = 1:height(gates)
    d = d.addedge(gates(idx,1),gates(idx,4));
    d = d.addedge(gates(idx,3),gates(idx,4));
end

n = d.Nodes.Name
for idx = 1:numel(n)
    n{idx} = [char(gates(gates(:,4) == string(n{idx}),2))  ' - '  n{idx}];
end

plot(d,Layout="layered",NodeLabel=n,Sources=[xk;yk],Sinks=[xk.replace("x","z")])
shg

nr = Inf;
while nr ~= registers.numEntries
nr = registers.numEntries;
for idx = height(gates):-1:1
    if isKey(registers, gates(idx,1)) && ...
            isKey(registers, gates(idx,3)) && ...
            ~isKey(registers, gates(idx,4))
        switch gates(idx,2)
            case "OR"
                registers(gates(idx,4)) = or(registers(gates(idx,1)), registers(gates(idx,3)));
            case "AND"
                registers(gates(idx,4)) = and(registers(gates(idx,1)), registers(gates(idx,3)));
            case "XOR"
                registers(gates(idx,4)) = xor(registers(gates(idx,1)), registers(gates(idx,3)));
        end
    end
end
end

k = registers.keys;
% xk = sort(k(k.startsWith('x')),"descend");
% yk = sort(k(k.startsWith('y')),"descend");
zk = sort(k(k.startsWith('z')),"descend");

x = bin2dec(string(registers(xk)).join(""));
y = bin2dec(string(registers(yk)).join(""));
zb = string(registers(zk)').join("");
z = bin2dec(zb)

zt = x + y
ztb = dec2bin(zt)
zt == z



[zb;ztb;string(double(char(zb)==char(ztb))).join("")]
% 2642 - too low