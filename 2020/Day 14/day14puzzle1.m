data = readlines("input.txt");
data = data.replace("mask", "mem[NaN]");
data(data.extractBefore(3) == "ma") = [];

data = data.split(["[","]"]).erase(" = ");
index = data(:,2).double(); number = data(:,3);
mem = repmat('0',max(index),36);

mask = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
for idx = 1:numel(index)
    if isnan(index(idx))
        mask = char(number(idx));
        continue
    end
    binData = dec2bin(number(idx).double);
    mem(index(idx),:) = char(padarray(double(binData),[0 36-numel(binData)],double('0'),'pre'));
    mem(index(idx),:);
    mem(index(idx),mask ~= 'X') = mask(mask ~= 'X');
%     index(idx)
%     mem(index(idx),:)
end

format long g
a = sum(bin2dec(mem))
sprintf('%f',a)