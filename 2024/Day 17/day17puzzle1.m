% day17puzzle1 - Daniel Breslan - Advent Of Code 2024
data = readlines("input.txt");

regsisters = data(1:3).extractAfter(": ").double();
input = data(end).extractAfter(": ").split(",").double;

day17puzzle1result = string(runOpcode(regsisters,input)).join(",")

function output = runOpcode(r,i)
ip = 1;
output = [];
while ip < numel(i)
    opcode = i(ip);
    operand = i(ip+1);
    switch opcode
        case 0 % adv
            r(1) = floor(r(1) / 2^combo(operand,r));
        case 1 % bxl
            r(2) = bitxor(r(2),operand);
        case 2 % bst
            r(2) = mod(combo(operand,r),8);
        case 3 % jnz
            if r(1) ~= 0
                ip = operand + 1;
                continue
            end
        case 4 % bxc
            r(2) = bitxor(r(2),r(3));
        case 5 % out
            output = [output, mod(combo(operand,r),8)];
        case 6 % bdv
            r(2) = floor(r(1) / 2^combo(operand,r));
        case 7 % cdv
            r(3) = floor(r(1) / 2^combo(operand,r));
    end
    ip = ip + 2;
end
end

function out = combo(operand,r)
% Combo operands 0 through 3 represent literal values 0 through 3.
% Combo operand 4 represents the value of register A.
% Combo operand 5 represents the value of register B.
% Combo operand 6 represents the value of register C.
% Combo operand 7 is reserved and will not appear in valid programs.
assert(operand ~= 7)
if operand < 4
    out = operand;
else
    out = r(operand-3);
end
end