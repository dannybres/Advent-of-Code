data = readlines("input.txt");
clc
% decodeData("D2FE28")
% [a,~,~,~,str] = decodeData("38006F45291200")
% decodeData("EE00D40C823060")
% [out, ~, ~, ver,str]  = decodeData("620080001611562C8802118E34")
% [out, ~, ~, ver]  = decodeData("620080001611562C8802118E34")
% [~, ~, ~, ver]  = decodeData("C0015000016115A2E0802F182340")
[a,~,~,ver,str] = decodeData(data)

function [out, used, remainingString, ver, str] = decodeData(input)
in = char(string(dec2bin(hex2dec(char(input)'))).join(""));
ver = bin2dec(in(1:3));
str.ver = ver;
type = bin2dec(in(4:6));
% out = 0;
% used = NaN;
if type == 4
    data = in(7:end);
    out = string(reshape(char(padarray(double(data),[0 5*ceil(numel(data)/5) ...
        - numel(data)],double('0'),'post')),5,[])');
    lasts = find(out.extractBefore(2) == "0");
    used = lasts(1)*5 + 6;
    out = bin2dec(out(1:lasts(1)).extractAfter(1).join(""));
    remainingString = in(used + 1:end);
else
    lengthTypeID = logical(str2double(in(7)));
    used = 0;
    out = {};
    if ~lengthTypeID
        length = bin2dec(in(8:8-1+15));
%         disp("15 bit length jobbie of " + length + "bits")
        dataToProcess = in(8+15:end);
        ogData = dataToProcess;
        str.child = {};
        while (numel(ogData) - numel(dataToProcess)) < length
            [out{end+1} , usedThisTime, dataToProcess, verRet, strOut] = decodeData(dataToProcess);
            ver = ver + verRet;
            used = used + usedThisTime;
            str.child{end+1} = strOut;
        end
        remainingString = dataToProcess;
    else
        length = bin2dec(in(8:8-1+11));
%         disp("11 bit length jobbie of " + length + "packets")
        dataToProcess = in(8+11:end);
        used = 0;
        str.child = {};
        while numel(out) < length
            [out{end+1} , usedThisTime, dataToProcess, verRet, strOut] = decodeData(dataToProcess);
            ver = ver + verRet;
            used = used + usedThisTime;
            str.child{end+1} = strOut;
        end
        remainingString = dataToProcess;
    end
end
end