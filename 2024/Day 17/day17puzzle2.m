%% day17puzzle2 - Daniel Breslan - Advent Of Code 2024
clc
data = readlines("input.txt");

registers = data(1:3).extractAfter(": ").double();
input = data(end).extractAfter(": ").split(",").double;

% The input is 16 digits, so we need 16 outputs, the 
% number of outputs is the same as the number of bits in the input divided 
% by 3, so we need a 16*3 bit number. We can workout what these bits are 
% by splitting the 48 bits into 16 3 bit numbers. The left most three bits
% will control the right most (last) output (it may also affect others, 
% but lets not worry!) once you set the left most three bits to give the 
% correct final output, you can work on the next three bits to give the
% penultimate output and so on. There are multiple options as you build the
% bits the work eg, 111000 and 101010 as the left most bits may both give
% the correct final two outputs, so we need to remember them both and keep
% searching along the bits for all options that will satisfy the input. The
% key fact is that the first 3 bits control the last out, the first six,
% control the last two outputs, so once you have soem bits that work
% changing bits to the right will never change the final outputs.

candidates = nan; % these are the known working three bit numbers (starting
% from left), set to nan to start with to allow the seatch to begin (as it 
% is kind of a queue of known good states.

for numberIdx = 1:numel(input) % loop through all 16 3 bit numbers to find 
    % what works, starting with the left most photo, which controls the
    % final output.
    newCandidates = []; 
    for candidateIdx = 1:height(candidates)
        if numberIdx ~= 1 % second interation  onwards use each candidates 
            % and search from 0 to 7 for next left hand number, other 
            % (right) numbers do not matter as we are just checking that 
            % the next (1 less than last time) output is correct 
            nu = ones(1,16);
            nu(1:width(candidates)) = candidates(candidateIdx,:);
        end
        opt = []; % new numbers that work to append to the current candidate
        for t = 0:7
            nu(numberIdx) = t;
            ni = bin2dec(reshape(dec2bin(nu,3)',1,[]));
            rr = zeros(3,1);
            rr(1) = ni;
            out = runOpcode(rr,input);
            if out(end - numberIdx + 1:end) == ...
                    reshape(input(end - numberIdx + 1:end),1,[])
                opt = [opt t]; % collect options we can append to current 
                % candidate to where the next (previous) output is correct
            end
        end
        if numberIdx == 1 % create new candidates lists for next time.
            newCandidates = opt(:);
        else
            newCandidates = [newCandidates;...
                repelem(candidates(candidateIdx,:),...
                numel(opt),1) opt(:)]; %#ok<*AGROW>
        end
    end
    candidates = newCandidates;
end

% Convert candidates to their binary representation concatenate the bits
% and convert back into a number, then find the miniumum
day17puzzle2result = ... 
    min(bin2dec(reshape(string(dec2bin(candidates,3)),[],16).join("")))

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