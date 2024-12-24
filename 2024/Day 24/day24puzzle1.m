%% day24puzzle1 - Daniel Breslan - Advent Of Code 2024
data = readlines("input.txt");
blIdx = find(data == "");
registers = data(1:blIdx-1).split(": ");
gates = data(blIdx+1:end).split(" ");
gates(:,4) = [];
registers = dictionary(registers(:,1),registers(:,2).double);

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

k = registers.keys
k = sort(k(k.startsWith('z')),"descend")

day24puzzle1result = bin2dec(string(registers(sort(k(k.startsWith('z')),"descend"))).join(""))

% 2642 - too low